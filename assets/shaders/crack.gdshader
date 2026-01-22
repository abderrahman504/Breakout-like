shader_type canvas_item;

uniform sampler2D crack_tex;
uniform float crack_thickness : hint_range(0., 1.) = .2;
varying vec4 modulate; 


void vertex(){
	modulate = COLOR;
}

void fragment() {
	float alpha = texture(crack_tex, UV).r;
	alpha = smoothstep(crack_thickness, 1., alpha);
	COLOR.a *= alpha;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
