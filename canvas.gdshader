shader_type canvas_item;

// Golden Ratio Φ ≈ 1.618
const float PHI = (1.0+sqrt(5.0))/2.0;

float noise(vec2 uv, float seed) {
	return fract(tan(distance(uv*PHI, uv)*seed)*uv.x);
}

void fragment() {
	// convert UV (0..1) to XY coord with center at origin (-1..1)
	vec2 CD = 2.0 * UV - vec2(1.0);
	// flip Y so up is positive
	CD.y = -CD.y;
	// scale to fit unit circle to screen and equalize X/Y resolution
	CD *= SCREEN_PIXEL_SIZE.yx / min(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y);

	float t = TAU * TIME + 64.0;

	COLOR.r = (1.5 + sin(t/3.0)) + noise(CD, t * 101.0);
	COLOR.b = dot(CD, CD);
	COLOR.g = (1.5 + sin(t/7.0)) * noise(CD.yx, t * 103.0);
}
