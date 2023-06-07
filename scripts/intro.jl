using DrWatson
@quickactivate "tmp"

# Here you may include files from the source directory
include(srcdir("dummy_src_file.jl"))


abstract type Hexagon end

struct HexagonAxial <: Hexagon
    q::Int
    r::Int
end

struct HexagonCubic <: Hexagon
    x::Int
    y::Int
    z::Int
end

struct HexagonOffsetOddR <: Hexagon
    q::Int
    r::Int
end

struct HexagonOffsetEvenR <: Hexagon

    q::Int
    r::Int
end



#Constructors
hexagon(x::Int, y::Int, z::Int) = HexagonCubic(x, y, z)
hexagon(q::Int, r::Int) = HexagonAxial(q, r)
i


# Convert between hexagon indexing
# # --------------------------------

function convert(::Type{HexagonAxial}, hex::HexagonCubic)
    HexagonAxial(hex.x, hex.z)
end


function convert(::Type{HexagonCubic}, hex::HexagonAxial)
        HexagonCubic(hex.q, hex.r, -hex.q - hex.r)
    end


# Neighbor hexagon iterator
# # -------------------------
#
struct HexagonNeighborIterator
     hex::HexagonCubic
end

const CUBIC_HEX_NEIGHBOR_OFFSETS = [
                                    1 -1  0;
                                    1  0 -1;
                                    0  1 -1;
                                    -1  1  0;
                                    -1  0  1;
                                    0 -1  1;
                                   ]


function iterate(it::HexagonNeighborIterator, state=1)
    state > 6 && return nothing
    dx = CUBIC_HEX_NEIGHBOR_OFFSETS[state, 1]
    dy = CUBIC_HEX_NEIGHBOR_OFFSETS[state, 2]
    dz = CUBIC_HEX_NEIGHBOR_OFFSETS[state, 3]
    neighbor = HexagonCubic(it.hex.x + dx, it.hex.y + dy, it.hex.z + dz)
    return (neighbor, state + 1)
end



# Diagonal hexagon iterator
# # -------------------------
#
struct HexagonDiagonalIterator
    hex::HexagonCubic
end

const CUBIC_HEX_DIAGONAL_OFFSETS = [
                                    +2 -1 -1;
                                    +1 +1 -2;
                                    -1 +2 -1;
                                    -2 +1 +1;
                                    -1 -1 +2;
                                    +1 -2 +1;
                                   ]

diagonals(hex::Hexagon) = HexagonDiagonalIterator(convert(HexagonCubic, hex))

length(::HexagonDiagonalIterator) = 6

function iterate(it::HexagonDiagonalIterator, state=1)
    state > 6 && return nothing
    dx = CUBIC_HEX_DIAGONAL_OFFSETS[state, 1]
    dy = CUBIC_HEX_DIAGONAL_OFFSETS[state, 2]
    dz = CUBIC_HEX_DIAGONAL_OFFSETS[state, 3]
    diagonal = HexagonCubic(it.hex.x + dx, it.hex.y + dy, it.hex.z + dz)
    return (diagonal, state + 1)
end


