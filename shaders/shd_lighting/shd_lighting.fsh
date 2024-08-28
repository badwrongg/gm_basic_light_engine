// Basic lighting attenuation model

vec3 get_radiance(float c)
{
	// UNPACK COLOR BITS
	vec3 col;
	col.b = floor(c * 0.0000152587890625);
	float blue_bits = c - col.b * 65536.0;
	col.g = floor(blue_bits * 0.00390625);
	col.r = floor(blue_bits - col.g * 256.0);
		
	// NORMALIZE 0-255
	return col * 0.00390625;
}

varying vec3 world_pos;
varying vec2 tex_coord;

uniform float u_lights[1024];

void main()
{
	vec3 albedo = texture2D(gm_BaseTexture, tex_coord).rgb;
	vec3 color = vec3(0.0);
	
	// Iterate over the lights array
	int count = int(u_lights[0]);
	int LI = 1;
	for (int i = 0; i < count; i++)
	{
		// Get light properties
		vec2 light_pos = vec2(u_lights[LI++], u_lights[LI++]);
		vec3 radiance = get_radiance(u_lights[LI++]);
		float radius = u_lights[LI++];
		
		// Attenuation
		// This is just quick and dirty example with no real control over things
		float dist = length(light_pos.xy - world_pos.xy) / radius;
		float attenuation = 5.0 / (dist * dist * 0.1 + 1.0);
		
		// Add to final color
		color += albedo * attenuation * radiance;
	}
	
    gl_FragColor = vec4(color, 1.0);
}
