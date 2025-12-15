shader_type canvas_item;

//uniform uint randi;
uniform float randf = 1.0;

// Golden Ratio Φ ≈ 1.618
const float PHI = (1.0+sqrt(5.0))/2.0;

// Obscure stuff
const vec2 vecX = vec2(PHI, TAU);

float noise(vec2 uv, float seed) {
	float v = 0.0;

	float s = sin(seed);
	float c = cos(seed);
	mat2 F = mat2(
		vec2(s, c),
		vec2(-c, s)
	);
	uv = F * uv;

	v = dot(uv, vecX);
	v = sin(v) * 12345.6789;

	//mat3 F = mat3(
		//vec3(1.0, 0.0, 0.0),
		//vec3(0.0, 1.0, 0.0),
		//vec3(0.0, 0.0, 1.0)
	//);
	//uv = (F * vec3(uv, 1.0)).xy;

	//v = tan(dot(uv*PHI, obsvec)*seed)*uv.x;
	//v = dot(uv+vecX, vecX);
	//v = dot(uv, v*vecX);
	//v *= seed;
	//v = tan(v);

	//vec2 r = vec2(PHI, TAU);
	//float v = dot(uv, r)*seed;
	//v = sin(v) * sqrt(2);

	return fract(v);
}


void fragment() {
	// convert UV (0..1) to XY coord with center at origin (-1..1)
	vec2 CD = 2.0 * UV - vec2(1.0);
	// flip Y so up is positive
	CD.y = -CD.y;
	// scale to fit unit circle to screen and equalize X/Y resolution
	CD *= SCREEN_PIXEL_SIZE.yx / min(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y);

	// fill black
	//COLOR.rgb = vec3(0.0);

	//float seed = 256.0 + TIME + randf;
	float seed = (1.0 + sin(TAU * TIME)) + randf;

	COLOR.r = noise(CD, seed++);
	COLOR.g = noise(CD, seed++);
	COLOR.b = noise(CD, seed);
	//COLOR.b = CD.x - CD.y > 0.0 ? 0.0 : 1.0;
	//COLOR.g = -1.0 + dot(CD, CD);

	//COLOR.r = (1.5 + sin(t/3.0)) + noise(CD, tan(t/17.0));
	//COLOR.g = (1.5 + sin(t/5.0)) * noise(CD.yx, tan(t/13.0));
}
