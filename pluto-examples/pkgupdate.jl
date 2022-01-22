#!/bin/sh
# -*-Julia-*-
#=
exec julia --startup-file=no --project=. "$0" "$@"
=#

using Pkg
Pkg.activate(@__DIR__)

using Pluto

notebooks=["nbproto.jl",
           "api-update.jl",
           "flux-reconstruction.jl",
           "problemcase.jl"
           ]
    

for notebook in notebooks
    println("Updating packages in $(notebook):")
    Pluto.activate_notebook_environment(joinpath(@__DIR__,notebook))
    Pkg.status()
    Pkg.update()
    Pkg.status()
    println("Updating of  $(notebook) done\n")
    Pkg.activate(@__DIR__)
end


dirs=["test","pluto-examples","docs"]
for dir in dirs 
    println("updating $(dir) environment")
    Pkg.activate(joinpath(@__DIR__,"..",dir))
    Pkg.status()
    Pkg.update()
    Pkg.status()
    Pkg.activate(@__DIR__)
end

