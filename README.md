# buildasaur
🦕 Windows ports of VFX software

# Software currently built for Windows with Python bindings (python 2.7)
 * OpenImageIO v2.1.10
 * OpenColorIO v1.1.0

# Install
1. Please grab the vcpkg to use these build scripts https://github.com/microsoft/vcpkg
2. clone OpenImageIO and OpenColorIO
3. apply patches found in the patches directory
4. Use the build-powershells to build OIIO and OCIO

# OIIO
Build example:
`.\build-oiio.ps1 -vcpkgdir ..\vcpkg -oiiodir ..\oiio`

# OCIO
Build example:
`.\build-ocio.ps1 -vcpkgdir ..\vcpkg -ociodir ..\OpenColorIO`

