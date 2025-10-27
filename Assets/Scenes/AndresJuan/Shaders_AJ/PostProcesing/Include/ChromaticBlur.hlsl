#ifndef CHROMATIC_BLUR
#define CHROMATIC_BLUR

#ifndef _BlitTexture
TEXTURE2D(_BlitTexture);
#endif


float2 ClampOffset(float2 coords, float2 size)
{
    return clamp(coords, 0, size -1);
}
void ChromaticBlur_float(float2 UV, float2 ScreenSize, float3 PerChannelOffsets, float Intensity, out float3 Filtered)
{
    Filtered = 0;
    float2 pixelCoords = UV * ScreenSize;
    float2 dir = UV*2.0 - 1.0;
    dir *= Intensity;

    for (int i = 0; i <16; i++)
    {
        float2 redCoords = ClampOffset(pixelCoords + dir* PerChannelOffsets.r * i, ScreenSize); 
        float2 greenCoords = ClampOffset(pixelCoords + dir* PerChannelOffsets.g * i, ScreenSize);
        float2 blueCoords = ClampOffset(pixelCoords + dir* PerChannelOffsets.b * i, ScreenSize);


        float red = LOAD_TEXTURE2D_LOD(_BlitTexture, redCoords, 0).r; 
        float green = LOAD_TEXTURE2D_LOD(_BlitTexture, greenCoords, 0).g; 
        float blue = LOAD_TEXTURE2D_LOD(_BlitTexture, blueCoords, 0).b;
        Filtered += float3(red, green, blue);
    }
    Filtered /= 16.0f;
}

#endif