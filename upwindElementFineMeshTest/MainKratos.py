#makes KratosMultiphysics backward compatible with python 2.6 and 2.7
from __future__ import print_function, absolute_import, division

import KratosMultiphysics
# Importing the base class
from KratosMultiphysics.CompressiblePotentialFlowApplication.potential_flow_analysis import PotentialFlowAnalysis
"""

For user-scripting it is intended that a new class is derived
from CompressiblePotentialFlowApplication to do modifications
"""

if __name__ == "__main__":

    with open("naca0012_upwind_transonic_parameters.json",'r') as parameter_file:
        parameters = KratosMultiphysics.Parameters(parameter_file.read())

    model = KratosMultiphysics.Model()
    simulation = PotentialFlowAnalysis(model,parameters)
    simulation.Run()