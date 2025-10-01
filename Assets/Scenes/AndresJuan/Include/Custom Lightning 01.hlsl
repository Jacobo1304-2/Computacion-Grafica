#ifndef CUSTOM_LIGHTNING_01_INCLUDED
#define CUSTOM_LIGHTNING_01_INCLUDED

//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

void GetMainLight_float(float3 positionWS, out float3 direction, out float3 color, out float shadowAttenuation)
{
    #if defined(SHADERGRAPH_PREVIEW)
        direction = normalize(float3(1, 1, -1));
        color = float3(1, 1, 1);
        shadowAttenuation = 1.0f;    
    #else
        float4 shadowCoord = TransformWorldToShadowCoord(positionWS);
        Light mainLight = GetMainLight(shadowCoord);
        direction = mainLight.direction;
        color = mainLight.color; 
        shadowAttenuation = mainLight.shadowAttenuation;
    #endif
}

#endif