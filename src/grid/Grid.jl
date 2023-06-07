#Grid Elements
#------------
abstract type GridElement end

struct HexagonalGridElement <: GridElement
    element::Hexagon
    val::Any
end


#Grid 
#------------
abstract type Grid end

struct HexagonalGrid <: Grid
    g::Matrix{HexagonalGridElement} 
end


hexgrid(g::Matrix{HexagonalGridElement}) = HexagonalGridElement(HexagonalGridElement)
