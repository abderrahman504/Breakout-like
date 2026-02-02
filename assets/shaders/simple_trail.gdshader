shader_type canvas_item;

uniform float len_px;
uniform float cutoff_point;

float negative_abs(float y, float offset, float scale){
	return -abs(y-offset)*scale + 1.;
}

float bell_shape(float y, float offset, float scale){
	return pow(cos(PI*(y - offset)*scale/2.), 3.5);
}

float wide_bell_shape(float y, float offset, float scale){
	return 1.-pow(abs(sin(PI*(y-offset)*scale/2.)), 3.5);
}

void fragment() {
	//COLOR.r = UV.x;
	float y_alpha = clamp(negative_abs(UV.y, 0.5, 2.5), 0., 1.);
	float std_x = UV.x * len_px;
	float x_alpha = smoothstep(len_px-cutoff_point, 0., std_x);
	COLOR.a = 1. * x_alpha;
}
