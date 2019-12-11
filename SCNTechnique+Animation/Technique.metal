//
//  Technique.metal
//  SCNTechnique+Animation
//
//  Created by Tomoya Hirano on 2019/12/12.
//  Copyright © 2019 Tomoya Hirano. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
#include <SceneKit/scn_metal>

struct custom_vertex_t
{
    float4 position [[attribute(SCNVertexSemanticPosition)]];
    float4 normal [[attribute(SCNVertexSemanticNormal)]];
};

struct out_vertex_t
{
    float4 position [[position]];
    float2 uv;
};

typedef struct {
    float aValue;
} Inputs;

constexpr sampler s = sampler(coord::normalized,
                              r_address::clamp_to_edge,
                              t_address::repeat,
                              filter::linear);

vertex out_vertex_t vertexShader(custom_vertex_t in [[stage_in]])
{
    out_vertex_t out;
    out.position = in.position;
    out.uv = float2( (in.position.x + 1.0) * 0.5, 1.0 - (in.position.y + 1.0) * 0.5 );
    return out;
};


fragment half4 fragmentShader(out_vertex_t vert [[stage_in]],
                                texture2d<float, access::sample> colorSampler [[texture(0)]],
                              constant Inputs& inputs [[buffer(0)]])
{
    // custom rendering
    float value = inputs.aValue;
    return half4(value, 0, 0, 1);
    
    // original rendering
    return half4(colorSampler.sample(s, vert.uv));
}
