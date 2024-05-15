shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
    // Get the original color of the pixel
	vec4 color = textureLod(screen_texture, SCREEN_UV, 0.0);
    //vec4 color = texture(TEXTURE, UV);
    
    // Convert the color to grayscale using the luminance formula
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    
    // Set the pixel color to grayscale
    COLOR = vec4(gray, gray, gray, color.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
