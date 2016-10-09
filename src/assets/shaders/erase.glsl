extern Image mask;

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
  vec4 result = Texel(texture, texture_coords);
  vec4 m = Texel(mask, texture_coords);

  if(m.a > 0)
  {
    result.a = 0;
  }
  return result;
}
