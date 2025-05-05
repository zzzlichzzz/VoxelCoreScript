# Укажите путь к директории
$directoryPath = "C:\path\to"

# Проверяем, существует ли директория
if (-Not (Test-Path -Path $directoryPath)) {
    # Если директории нет, создаем её
    New-Item -ItemType Directory -Path $directoryPath
    Write-Output "Директория '$directoryPath' успешно создана."
} else {
    Write-Output "Директория '$directoryPath' уже существует."
}

# Переходим в директорию
Set-Location -Path $directoryPath
Write-Output "Текущая директория: $(Get-Location)"

if (-Not (Test-Path -Path ".\vcpkg")) {
    # Если папки нет, клонируем репозиторий
    git clone https://github.com/microsoft/vcpkg.git
    Write-Output "vcpkg успешно скачан."
} else {
    Write-Output "vcpkg уже существует."
}

cd vcpkg


.\bootstrap-vcpkg.bat
$env:VCPKG_ROOT = "$directoryPath\vcpkg"
$env:PATH = "$env:VCPKG_ROOT;$env:PATH"


$username = $env:USERNAME


$directoryVoxelCore = "C:\Users\$username\source\repos"


# Проверяем, существует ли директория
if (-Not (Test-Path -Path $directoryVoxelCore)) {
    # Если директории нет, создаем её
    New-Item -ItemType Directory -Path $directoryVoxelCore
    Write-Output "Директория '$directoryVoxelCore' успешно создана."
} else {
    Write-Output "Директория '$directoryVoxelCore' уже существует."
}

cd C:\Users\$username\source\repos

# Проверяем, существует ли папка VoxelEngine-Cpp
if (-Not (Test-Path -Path ".\VoxelEngine-Cpp")) {
    # Если папки нет, клонируем репозиторий
    git clone --recursive https://github.com/MihailRis/VoxelEngine-Cpp.git
    Write-Output "VoxelEngine-Cpp успешно скачан."
} else {
    Write-Output "VoxelEngine-Cpp уже существует."
}


cd VoxelEngine-Cpp

# Путь к файлам мира и контента
    $WorldPath = "C:\Users\$username\source\repos\VoxelEngine-Cpp\build\Debug\worlds"
    $ContentPath = "C:\Users\$username\source\repos\VoxelEngine-Cpp\build\Debug\content"

# Куда временно переносит сохранения
    $destinationWorldPath = "C:\Users\$username\source"
    $destinationContentPath = "C:\Users\$username\source"


# Проверяем, существует ли папка build
if (Test-Path -Path ".\build") {
    
    # Проверяем, существует ли исходная папка World
    if (Test-Path -Path $WorldPath) {
        try {
            # Перемещаем папку
         Move-Item -Path $WorldPath -Destination $destinationWorldPath -Force
         Write-Output "Папка '$WorldPath' успешно перемещена в '$destinationWorldPath'."
     } catch {
            Write-Output "Ошибка при перемещении папки: $_"
     }
    } else {
    Write-Output "Исходная папка '$WorldPath' не существует."
    }

    # Проверяем, существует ли исходная папка Content
    if (Test-Path -Path $ContentPath) {
        try {
            # Перемещаем папку
         Move-Item -Path $ContentPath -Destination $destinationContentPath -Force
         Write-Output "Папка '$ContentPath' успешно перемещена в '$destinationContentPath'."
     } catch {
            Write-Output "Ошибка при перемещении папки: $_"
     }
    } else {
    Write-Output "Исходная папка '$ContentPath' не существует."
    }



    # Если папка build существует, удаляем её
    Remove-Item -Path ".\build" -Recurse -Force
    Write-Output "Папка 'build' успешно удалена."
} else {
    Write-Output "Папка 'build' не существует."
}

cmake --preset default-vs-msvc-windows

cmake --build --preset default-vs-msvc-windows

 Start-Sleep -Seconds 3

 #Где сохранённые данные
 
 $worlds = "C:\Users\$username\source\worlds"
 $content = "C:\Users\$username\source\content"


 #Куда переноси сохраненные данные

 $DestinationWorldContent = "C:\Users\$username\source\repos\VoxelEngine-Cpp\build\Debug"


            # Перемещаем папку
         Move-Item -Path $worlds -Destination $DestinationWorldContent -Force
     


            # Перемещаем папку
         Move-Item -Path $content -Destination $DestinationWorldContent -Force
     


# Пауза для просмотра вывода
Read-Host -Prompt "Press Enter to exit"