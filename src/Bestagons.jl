module Bestagons
using Reexport
using DrWatson
import Base: convert, length, collect, iterate
@reexport using Revise
export grids,center,hexagon,HexagonAxial,HexagonCubic,hexpoints,cube,neighbor,HexagonVertexIterator, vertices,
       HexagonNeighborIterator, neighbors,
       HexagonDiagonalIterator, diagonals

export Grid, HexagonalGridElement,HexagonalGrid,hexgrid


include("grid/hexagons/Hexagons.jl")
include("grid/hexagons/HexGrid.jl")
include("grid/Grid.jl")


end # module
