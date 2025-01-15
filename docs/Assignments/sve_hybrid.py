import numpy as np
import tqdm

def run_model(nTimes, saveT, dt, dx, zb, b, A, Q,
              Qup=None, Aup=None, Qdown=None, Adown=None,
              Manning=0.0, drylim=1e-10, kappa = 0.0):
    g = 9.81
    nx = len(Q)
    x = np.arange(nx) * dx

    Z = np.zeros(nx)  # sea floor + water depth from sea floor

    A[A<0] = 1e-3

    Z = A / b + zb

    u = np.zeros(nx)  # average velocity m/s (= Q / A)
    # temp variables...

    Sl = np.zeros_like(Q)
    Sr = np.zeros_like(Q)
    Qh = np.zeros_like(Q)
    Qq = np.zeros_like(Q)
    Anew = np.zeros_like(A)
    Qnew = np.zeros_like(Q)
    momf = np.zeros_like(Q)
    dzdx = np.zeros_like(Q)
    cstar = np.zeros_like(Q)
    ustar = np.zeros_like(Q)

    saveA = np.zeros((int(nTimes/saveT)+1, len(A)))
    saveQ = np.zeros((int(nTimes/saveT)+1, len(A)))
    saveind = 0

    _in = np.arange(1,nx-1)
    _lt = np.arange(0,nx-2)
    _rt = np.arange(2,nx)

    dzdx0 =  np.zeros_like(dzdx)
    dzF =  np.zeros_like(dzdx)

    print('Zold_000', np.min(np.abs(A+zb)), np.max(np.abs(A+zb)))

    A0 = A.copy()

    _fast_SlSr = False

    superUp = (Qup is not None) and (Aup is not None)
    subUp = (Qup is not None) and (Aup is None)
    for nn in range(nTimes):
        if nn % saveT == 0:
            print('Save')
            saveA[saveind] = A
            saveQ[saveind] = Q
            print(np.max(np.abs(dzdx)))
            saveind += 1
            print('momf', np.max(np.abs(momf)))
            print('dzdx', np.max(np.abs(dzdx)))
            print('Anew', np.min(np.abs(Anew)), np.max(np.abs(Anew)))
            print('Znew', np.min(np.abs(Anew+zb)), np.max(np.abs(Anew+zb)))
            print('Zold', np.min(np.abs(A+zb)), np.max(np.abs(A+zb)))


        Anew = A.copy()
        Qnew = Q.copy()


        u[0] = Q[0] / A[0]
        # set downstream BC:
        Anew[-1] = Anew[-2]
        Qnew[-1] = Qnew[-2]
        if Adown is not None:
            Anew[-1] = Adown
        if Qdown is not None:
            Qnew[-1] = Qdown


        u[-1] = Qnew[-1] / Anew[-1]

        # calc u and Z
        h = A / b
        Z = zb + h
        u[_in] = Q[_in]/A[_in]
        u[_in][h[_in]<drylim] = 0

        ## Continuity
        # calc Sl, Sr
        if _fast_SlSr:
            Sl[_in] =  5.0/8.0*u[_lt] + 3.0/8.0*u[_in] - 0.25 * np.sqrt(g*A[_lt]/b[_lt]) - 0.75 * np.sqrt(g*A[_in]/b[_in])
            Sr[_in] =  3.0/8.0*u[_lt] + 5.0/8.0*u[_in] + 0.75 * np.sqrt(g*A[_lt]/b[_lt]) + 0.25 * np.sqrt(g*A[_in]/b[_in])
        else:
            cstar[_in] = 0.5*(np.sqrt(g*h[_lt]) + np.sqrt(g*h[_in])) + (u[_lt]-u[_in]) / 4.0
            ustar[_in] = 0.5 * (u[_lt] + u[_in]) + np.sqrt(g*h[_lt]) - np.sqrt(g*h[_in])
            Sl[_in] = np.minimum(u[_lt]-np.sqrt(g*h[_lt]), ustar[_in] - cstar[_in])
            Sr[_in] = np.maximum(u[_in]+np.sqrt(g*h[_in]), ustar[_in] + cstar[_in])

        # now set Sl and Sr for regions with dry cells....
        dryind = np.where((A < drylim))[0]
        for d in dryind:
            print(d)
            if d-1 not in dryind:
                ind = d-1
                #print('Dry to right', ind)
                Sl[ind] = u[ind-1] - np.sqrt(g*h[ind-1])
                Sr[ind] = u[ind-1] + 2 * np.sqrt(g*h[ind-1])
            elif d+1 not in dryind:
                ind = d + 1
                #print('Dry to left', ind)
                Sl[ind]  = u[ind] - 2 * np.sqrt(g*h[ind])
                Sr[ind]  = u[ind] + np.sqrt(g*h[ind])

        # calc Qs
        Qh[_lt] = (Sr[_in]*Q[_lt] - Sl[_in] * Q[_in] + Sl[_in] * Sr[_in]*(A[_in]-A[_lt])) / (Sr[_in] - Sl[_in])
        Qh[_lt][Sr[_in]<0] = Q[_in][Sr[_in]<0]
        Qh[_lt][Sl[_in]>=0] = Q[_lt][Sl[_in]>=0]
        Qh[-2] = Qh[-3]

        # calc A

        Anew[_in] = A[_in] + dt / dx * (Qh[_lt] - Qh[_in])

        diff =  dt * kappa / dx**2 * (Anew[_rt] - 2*Anew[_in] + Anew[_lt])
        Anew[_in] = Anew[_in] + diff


        hnew = A / b
        Znew = zb + hnew


        ## Momentum.

        # upwind scheme momentum flux
        momf[_in] = (Q[_in]**2 / Anew[_in] - Q[_lt]**2 / Anew[_lt]) / (x[_in]-x[_lt])
        # we don't need Qh anymore, so reuse:
        Qq[_in] = (Q[_rt]**2 / A[_rt] - Q[_in]**2 / Anew[_in]) / (x[_rt]-x[_in])
        momf[_in][Q[_in]<0] = Qq[_in][Q[_in]<0]

        # There is a higher order thing to do for this that is better, so maybe fix later, but for flat
        dzdx0[_in] = (Z[_rt] - Z[_lt]) / (x[_rt] - x[_lt])
        dzdx = dzdx0
        # forward:
        dzF[2:-1] = (Z[:-3] - 7 * Z[1:-2] + 3 * Z[2:-1] + 3* Z[3:]) / 4 / (x[3:]-x[1:-2])
        inF = Q[2:-1]>0
        dzdx[2:-1][inF] = dzF[2:-1][inF]

        dzF[1:-2] = (-3 * Z[:-3] - 3 * Z[1:-2] + 7 * Z[2:-1] - Z[3:]) / 4 / (x[2:-1]-x[0:-3])
        inF = Q[1:-2]<0
        dzdx[1:-2][inF] = dzF[1:-2][inF]

        #dzdx = dzdx0

        Qnew[_in] = Q[_in] - dt * momf[_in] - dt*g * Anew[_in] * dzdx[_in]


        # Friction:
        R = A / (b + 2*(A/b))
        # R = 0.5  + 0*R
        # print(g * Manning[_in]**2 * np.abs(Qnew[_in]) * dt / R[_in]**(4/3) / Anew[_in])
        #fric = (1.0 + g * Manning[_in]**2 * np.abs(Qnew[_in]+Q[_in]) * dt / R[_in]**(4/3) / Anew[_in])
        #fric[np.abs(Anew[_in] - 2.0) < 0.01] = 1.0
        #Qnew[_in] = Qnew[_in] / fric

        fric = - dt * (g * Manning[_in]**2 * np.abs(Q[_lt])*Q[_lt]) / R[_in]**(4/3) / A[_in]

        Qnew[_in] = Qnew[_in] + fric
        diff = dt * kappa / dx**2 * (Q[_rt] - 2*Q[_in] + Q[_lt])
        Qnew[_in] = Qnew[_in] + diff


        Qnew[(Anew/b)<drylim] = 0.0
        # print('Qnew', np.min(np.abs(Qnew)), np.max(np.abs(Qnew)))

        # Boundary conditions
        if subUp:
            # this is best for subcritical
            if nn == 0:
                print('upstream subcritical')
            Qnew[0] = Qup
            # get Z from 1 and 2
            z = 2 * (A[1] / b[1] + zb[1]) - (A[2] / b[2] + zb[2])
            Anew[0] = (z - zb[0]) * b[0]

        elif superUp:
            if nn == 0:
                print('super critical')
            Qnew[0] = Qup
            Anew[0] = Aup
            Anew[1] = Aup
            Qnew[1] = Qup
            # sponge
            #Anew[2:32] += (Aup - A[2:32])/(np.arange(2, 32))
            #Qnew[2:32] += (Qup - Q[2:32])/(np.arange(2, 32))



        Ncfl = np.max(dt/dx*(np.abs(Qnew/Anew) + np.sqrt(g*Anew/b)))
        #print(Ncfl)

        if Ncfl > 0.3:
            dt = dt / 4.0
            print('new dt', dt)
            Anew = saveA[saveind-2, :]
            Qnew = saveQ[saveind-2, :]
        if Ncfl < 0.03:
            dt = dt * 4.0
            print('new dt', dt)


        if np.all(np.isfinite(A)):
            A = Anew
            Q = Qnew
        else:
            #A = saveA[saveind-1, :]
            #Q = saveQ[saveind-1, :]
            #saveind = saveind - 1
            #dt = dt / 2
            saveA = saveA[:saveind,:]
            saveQ = saveQ[:saveind, :]
            print(f'Failed on {nn}')
            return saveA, saveQ
    return saveA, saveQ

def run_modelFVM(nTimes, saveT, dt, dx, zb, b, A, Q,
              Qup=None, Aup=None, Qdown=None, Adown=None,
              Manning=0.0, drylim=1e-10, kappa = 0.0, K4=0.0):
    g = 9.81
    nx = len(Q)
    x = np.arange(nx) * dx

    Z = np.zeros(nx)  # sea floor + water depth from sea floor

    A[A<0] = 1e-3

    Z = A / b + zb

    u = np.zeros(nx)  # average velocity m/s (= Q / A)
    # temp variables...

    Sl = np.zeros_like(Q)
    Sr = np.zeros_like(Q)
    Qh = np.zeros_like(Q)
    Qq = np.zeros_like(Q)
    Anew = np.zeros_like(A)
    Qnew = np.zeros_like(Q)
    momf = np.zeros_like(Q)
    dzdx = np.zeros_like(Q)
    cstar = np.zeros_like(Q)
    ustar = np.zeros_like(Q)

    saveA = np.zeros((int(nTimes/saveT)+1, len(A)))
    saveQ = np.zeros((int(nTimes/saveT)+1, len(A)))
    saveind = 0

    _in = np.arange(1,nx-1)
    _lt = np.arange(0,nx-2)
    _rt = np.arange(2,nx)

    dzdx0 =  np.zeros_like(dzdx)
    dzF =  np.zeros_like(dzdx)


    A0 = A.copy()

    _fast_SlSr = False

    superUp = (Qup is not None) and (Aup is not None)
    subUp = (Qup is not None) and (Aup is None)
    for nn in tqdm.tqdm(range(nTimes), 'Running model'):
        if nn % saveT == 0:
            saveA[saveind] = A
            saveQ[saveind] = Q
            saveind += 1
            #print('momf', np.max(np.abs(momf)))
            #print('dzdx', np.max(np.abs(dzdx)))
            #print('Anew', np.min(np.abs(Anew)), np.max(np.abs(Anew)))
            #print('Znew', np.min(np.abs(Anew+zb)), np.max(np.abs(Anew+zb)))
            #print('Zold', np.min(np.abs(A+zb)), np.max(np.abs(A+zb)))


        Anew = A.copy()
        Qnew = Q.copy()


        u[0] = Q[0] / A[0]
        # set downstream BC:
        Anew[-1] = Anew[-2]
        Qnew[-1] = Qnew[-2]
        if Adown is not None:
            Anew[-1] = Adown
        if Qdown is not None:
            Qnew[-1] = Qdown

        u[-1] = Qnew[-1] / Anew[-1]

        # calc u and Z
        h = A / b
        Z = zb + h
        u[_in] = Q[_in]/A[_in]
        u[_in][h[_in]<drylim] = 0

        ## Continuity

        k = 0 * Q + 0.5
        inds = np.where((Q[_in]>0) & (Q[_lt]>0))[0]
        k[_in[inds]] = 0
        inds = np.where((Q[_in]<0) & (Q[_rt]<0))[0]
        k[_in[inds]] = 1
        k[0] = 0
        k[-1] = 0   # for outflow

        Qh[_in] = (Q[_in] + Q[_rt]) / 2.0
        # k= 0
        Qh[_in][k[_in]==0] = Q[_in][k[_in]==0]
        # k = 1
        Qh[_in][k[_in]==1] = Q[_rt][k[_in]==1]
        Qh[0] = Q[0]

        # calc A

        Anew[_in] = A[_in] + dt / dx * (Qh[_lt] - Qh[_in])
        diff =  dt * kappa  / dx**2 * (Anew[_rt] - 2*Anew[_in] + Anew[_lt])
        Anew[_in] = Anew[_in] + diff

        diff = dt * K4 / dx**4 * (Anew[_lt[1:-1]-1] - 4 * Anew[_lt[1:-1]] + 6 * Anew[_in[1:-1]] - 4 * Anew[_rt[1:-1]] + Anew[_rt[1:-1]+1])
        Anew[_in[1:-1]] = Anew[_in[1:-1]] - diff

        ## Momentum.
        if subUp:
            # this is best for subcritical
            if nn == 0:
                print('upstream subcritical')
            Qnew[0] = Qup # * np.min([(nn*dt/200), 1.0])
            # get Z from 1 and 3
            z = 2 * (A[1] / b[1] + zb[1]) - (A[2] / b[2] + zb[2])
            #z = (3/2) * (A[1] / b[1] + zb[1]) - (A[3] / b[3] + zb[3])
            Anew[0] = (z - zb[0]) * b[0]

        hnew = Anew / b
        Z = zb + hnew

        # upwind scheme momentum flux
        qq = Q**2 / A
        Qh[_in] = (qq[_in]+qq[_rt]) / 2.0
        Qh[_in][k[_in] == 0] = qq[_in][k[_in] == 0]
        # k = 1
        Qh[_in][k[_in] == 1] = qq[_rt][k[_in] == 1]
        Qh[0] = qq[0]

        Qnew[_in] = Q[_in] + dt / dx * (Qh[_lt] - Qh[_in])

        # 50/50 upwind/downwind
        dzdxdn = np.zeros_like(dzdx)
        dzdxdn[_in] = ((Z[_lt] - Z[_rt]) / (x[_lt] - x[_rt]))
        dzdxdn[_in][k[_in]==0] = ((Z[_in] - Z[_rt]) / (x[_in] - x[_rt]))[k[_in]==0]
        dzdxdn[_in][k[_in]==1] = ((Z[_in] - Z[_lt]) / (x[_in] - x[_lt]))[k[_in]==1]

        dzdxup = np.zeros_like(dzdx)
        dzdxup[_in] = ((Z[_lt] - Z[_rt]) / (x[_lt] - x[_rt]))
        dzdxup[_in][k[_in]==0] = ((Z[_in] - Z[_lt]) / (x[_in] - x[_lt]))[k[_in]==0]
        dzdxup[_in][k[_in] == 1] = ((Z[_in] - Z[_rt]) / (x[_in] - x[_rt]))[k[_in] == 1]


        # get up/down weight
        u[_in] = Q[_in]/A[_in]
        u[_in][h[_in]<drylim] = 0

        au = np.abs(u)
        Cdown = dt / dx * (au[_rt] + au[_in]) / 2
        Cdown[k[_in] == 1] =  dt / dx * (au[_lt] + au[_in])[k[_in] == 1] / 2
        Cup = dt / dx * (au[_lt] + au[_in]) / 2
        Cup[k[_in] == 1] =  dt / dx * (au[_rt] + au[_in])[k[_in] == 1] / 2

        dzdx = (dzdxup + dzdxdn) / 2
        dzdx[_in] = dzdxdn[_in] * (1-Cdown) + dzdxup[_in] * Cdown
        #dzdx[_in] = dzdxdn[_in]  # FIX

        Qnew[_in] = Qnew[_in] - dt*g * Anew[_in] * dzdx[_in]

        # Friction:
        R = A / (b + 2*(A/b))

        fric = - dt * (g * Manning[_in]**2 * np.abs(Qnew[_lt])*Qnew[_lt]) / R[_in]**(4/3) / A[_in]

        #Qnew[_in] = Qnew[_in] + fric
        diff = dt * kappa / dx**2 * (Q[_rt] - 2*Q[_in] + Q[_lt])
        Qnew[_in] = Qnew[_in] + diff
        # quadratic friction
        # 1	−4	6	−4	1
        diff = dt * K4 / dx**4 * (Qnew[_lt[1:-1]-1] - 4 * Qnew[_lt[1:-1]] + 6 * Qnew[_in[1:-1]] - 4 * Qnew[_rt[1:-1]] + Qnew[_rt[1:-1]+1])
        Qnew[_in[1:-1]] = Qnew[_in[1:-1]] - diff

        # Boundary conditions
        if subUp:
            # this is best for subcritical
            if nn == 0:
                print('upstream subcritical')
            Qnew[0] = Qup #* np.min([(nn*dt/200), 1.0])
            # get Z from 1 and 3
            #z = 2 * (A[1] / b[1] + zb[1]) - (A[2] / b[2] + zb[2])
            z = (3/2) * (A[1] / b[1] + zb[1]) - (A[3] / b[3] + zb[3])
            Anew[0] = (z - zb[0]) * b[0]
            Anew[0] = Anew[1]

        elif superUp:
            if nn == 0:
                print('super critical')
            Qnew[0] = Qup
            Anew[0] = Aup
            Anew[1] = Aup
            Qnew[1] = Qup
            # sponge
            # Anew[2:32] += (Aup - A[2:32])/(np.arange(2, 32))
            # Qnew[2:32] += (Qup - Q[2:32])/(np.arange(2, 32))

        # wetting and drying
        Qnew[(Anew/b) < drylim] = 0.0
        Anew[(Anew/b) < drylim] = drylim * b[(Anew/b) < drylim]

        Ncfl = np.max(dt/dx*(np.abs(Qnew/Anew) + np.sqrt(g*Anew/b)))
        # print(Ncfl)

        #if Ncfl > 0.3:
        #    dt = dt / 4.0
        #    print('new dt', dt)
        #    Anew = saveA[saveind-2, :]
        #    Qnew = saveQ[saveind-2, :]
        #if Ncfl < 0.03:
        #    dt = dt * 4.0
        #    print('new dt', dt)


        if (np.all(np.isfinite(A))) and (np.max(h)<0.6):
            A = Anew
            Q = Qnew
        else:
            #A = saveA[saveind-1, :]
            #Q = saveQ[saveind-1, :]
            #saveind = saveind - 1
            #dt = dt / 2
            saveA = saveA[:saveind,:]
            saveQ = saveQ[:saveind, :]
            print(f'Failed on {nn}')

            return saveA, saveQ
    return saveA, saveQ