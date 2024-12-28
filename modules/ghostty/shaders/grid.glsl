
# modified from https://www.shadertoy.com/view/Wt33Wf
const vec3 gridHue = vec3(90.,255.,90.)/255.;

float grid(vec2 uv, float battery)
{
    vec2 size = vec2(uv.y, uv.y * uv.y * 0.2) * 0.01;
    uv += vec2(0.0, iTime * 1.1 * (battery + 0.05));
    uv = abs(fract(uv) - 0.5);
 	vec2 lines = smoothstep(size, vec2(0.0), uv);
 	lines += smoothstep(size * 5.0, vec2(0.0), uv) * 0.4 * battery;
    return clamp(lines.x + lines.y, 0.0, 3.0);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (2.0 * fragCoord.xy - iResolution.xy)/iResolution.y;
    // vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 uv2 = fragCoord.xy / iResolution.xy;
    float battery = 0.5;

    {
        // Grid
        float fog = smoothstep(0.1, -0.02, abs(uv.y + 0.2));
        vec3 col = vec3(0.0, 0.1, 0.2);
        if (uv.y > -0.2)
        {
            uv.y = 3.0 / (abs(uv.y + 0.2) + 0.05);
            uv.x *= uv.y * 1.0;
            float gridVal = grid(uv, battery);
            col = mix(col, gridHue, gridVal);
        }

        col += fog * fog * fog;
        col = mix(vec3(col.r, col.r, col.r) * 0.5, col, battery * 0.7);


        // Sample the terminal screen texture including alpha channel
        vec4 terminalColor = texture(iChannel0, uv2);

        // Use the terminal's original alpha
        fragColor = vec4(col + terminalColor.rgb, terminalColor.a);

    }

}