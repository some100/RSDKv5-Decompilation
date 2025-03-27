add_executable(RetroEngine ${RETRO_FILES})

set(RETRO_SUBSYSTEM "SDL2" CACHE STRING "The subsystem to use")

target_link_options(RetroEngine PRIVATE 
                    -sINITIAL_MEMORY=128mb 
                    -Oz
                    -sLZ4
                    -sWASM_BIGINT 
                    --use-port=ogg
                    --use-port=vorbis
                    --use-preload-cache
                    --preload-file ../Data.rsdk@/ 
                    --embed-file ../Settings.ini@/
)
target_compile_options(RetroEngine PRIVATE 
                    --use-port=ogg
                    --use-port=vorbis
                    -Oz
)

set(COMPILE_THEORA on)

if(RETRO_SUBSYSTEM STREQUAL "OGL") # this doesn't work yet
    target_compile_options(RetroEngine PRIVATE --use-port=contrib.glfw3)
    target_link_options(RetroEngine PRIVATE --use-port=contrib.glfw3)
elseif(RETRO_SUBSYSTEM STREQUAL "SDL2")
    target_compile_options(RetroEngine PRIVATE --use-port=sdl2)
    target_link_options(RetroEngine PRIVATE --use-port=sdl2)
endif()

if(RETRO_MOD_LOADER)
    set_target_properties(RetroEngine PROPERTIES
        CXX_STANDARD 17
        CXX_STANDARD_REQUIRED ON
    )
endif()

set(CMAKE_EXECUTABLE_SUFFIX ".html")