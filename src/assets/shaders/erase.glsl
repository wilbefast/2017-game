extern Image mask;

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
  vec4 result = Texel(texture, texture_coords);
  vec4 m = Texel(mask, texture_coords);

  result.a *= 1 - m.a;
  return result;
}
