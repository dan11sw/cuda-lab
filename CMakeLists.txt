# CMakeList.txt: проект CMake для CudaRuntime; включите исходный код и определения,
# укажите здесь логику для конкретного проекта.
#
cmake_minimum_required (VERSION 3.8)

# Включение горячей перезагрузки для компиляторов MSVC, если поддерживается.
if (POLICY CMP0141)
  cmake_policy(SET CMP0141 NEW)
  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<IF:$<AND:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>,$<$<CONFIG:Debug,RelWithDebInfo>:EditAndContinue>,$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>>")
endif()

project ("CudaRuntime" LANGUAGES C CXX CUDA)

find_package(CUDA REQUIRED)

# Включение стандартов для C и C++
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} 
    -gencode arch=compute_75 code=sm_75
    -Xcompiler=-Wall -Wextra
    --default-language c++)

# Добавьте источник в исполняемый файл этого проекта.
add_executable (CudaRuntime "CudaRuntime.cu" "CudaRuntime.h" "common/book.h")

# Настройки для целевого объекта
set_target_properties(CudaRuntime
    PROPERTIES
    CUDA_SEPARABLE_COMPILATION ON
    CUDA_RESOLVE_DEVICE_SYMBOLS ON
)

# Подключение директорий с заголовками
target_include_directories(CudaRuntime PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CUDA_INCLUDE_DIRS}
)

# Подключение библиотек
target_link_libraries(CudaRuntime PRIVATE
    ${CUDA_LIBRARIES}
    ${CUDA_cudart_static_LIBRARY}
)

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET CudaRuntime PROPERTY CXX_STANDARD 20)
endif()

# TODO: Добавьте тесты и целевые объекты, если это необходимо.
