# %%
from openmm.app import CharmmParameterSet, CharmmPsfFile, Simulation, CutoffPeriodic
from openmm import Platform, VerletIntegrator, Vec3, State
from openmm.unit import angstroms, picoseconds, Quantity, kilocalorie_per_mole

import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl
mpl.rcParams['mathtext.default'] = 'regular'


# %%
params = CharmmParameterSet('dummy.str')
temp = 320
platform = Platform.getPlatformByName('CUDA')
prop = {'Precision': 'mixed'}
psf = CharmmPsfFile('dum.psf')

psf.setBox(30.0*angstroms, 30.0*angstroms, 30.0*angstroms)

system = psf.createSystem(
    params, 
    nonbondedMethod=CutoffPeriodic, 
    nonbondedCutoff=15*angstroms,
    switchDistance=12*angstroms,
    constraints=None, 
    ewaldErrorTolerance=0.0001
)

# for i, f in enumerate(system.getForces()):
#     f.setForceGroup(i)
#     print(f.getName())
    

integrator = VerletIntegrator(0.001*picoseconds)
simulation = Simulation(
    psf.topology, 
    system, 
    integrator, 
    platform, 
    prop
)

simulation.context.setPositions(
    Quantity(
        value=[Vec3(x=0.0, y=0.0, z=0.0), Vec3(x=1., y=0.0, z=0.0)], 
        unit=angstroms
    )
)

# %% [markdown]
# # Get plots

# %%
ljenegy = []
ljforce = []
x = np.linspace(2, 28, num=500)

# %%
for i in x:
    simulation.context.setPositions(
        Quantity(
            value=[Vec3(x=0, y=0, z=0), Vec3(x=i, y=0, z=0)], 
            unit=angstroms
        )
    )
    
    state: State = simulation.context.getState(getEnergy=True, getForces=True)
    
    ljenegy.append(
        state.getPotentialEnergy().value_in_unit(kilocalorie_per_mole)
    )

    ljforce.append(
        state.getForces().value_in_unit(kilocalorie_per_mole/angstroms)[0][0]
    )

np.savetxt("cal_ene_force.dat", 
           np.asarray(list(zip(x,ljenegy, ljforce))),
           '%20.10f,%20.10f,%20.10f',delimiter=','
)


