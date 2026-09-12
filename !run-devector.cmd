@if exist "x-emu-devector\rom\batty.rom" (
  del "x-emu-devector\rom\batty.rom"
)

copy batty.rom "x-emu-devector\rom\batty.rom"

start x-emu-devector\devector -path "x-emu-devector\rom\batty.rom"