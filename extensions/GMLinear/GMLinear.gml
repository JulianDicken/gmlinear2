#define rmn
/// @description rmn(m, n, ...)
/// @param m
/// @param n
/// @param ...
{
  var m = argument[0],
      n = argument[1];
  var mm = 0,
      nn = 0;
  var M;
  for (var i = 2; i < argument_count; i++) {
    M[mm, nn] = argument[i];
    if (++nn == n) {
      mm++;
      nn = 0;
    }
  }
  return M;
}

#define rmn_zero
/// @description rmn_zero(m, n)
/// @param m
/// @param n
{
  var M;
  for (var i = 0; i < argument0; i++) {
    for (var j = 0; j < argument1; j++) {
      M[i, j] = 0;
    }
  }
  return M;
}

#define rnn
/// @description rnn(...)
/// @param ...
{
  var result;
  switch (argument_count) {
    case 1:
      result[0, 0] = argument[0];
    break;
    case 4:
      result[0, 0] = argument[0];
      result[0, 1] = argument[1];
      result[1, 0] = argument[2];
      result[1, 1] = argument[3];
    break;
    case 9:
      result[0, 0] = argument[0];
      result[0, 1] = argument[1];
      result[0, 2] = argument[2];
      result[1, 0] = argument[3];
      result[1, 1] = argument[4];
      result[1, 2] = argument[5];
      result[2, 0] = argument[6];
      result[2, 1] = argument[7];
      result[2, 2] = argument[8];
    break;
    case 16:
      result[0, 0] = argument[0];
      result[0, 1] = argument[1];
      result[0, 2] = argument[2];
      result[0, 3] = argument[3];
      result[1, 0] = argument[4];
      result[1, 1] = argument[5];
      result[1, 2] = argument[6];
      result[1, 3] = argument[7];
      result[2, 0] = argument[8];
      result[2, 1] = argument[9];
      result[2, 2] = argument[10];
      result[2, 3] = argument[11];
      result[3, 0] = argument[12];
      result[3, 1] = argument[13];
      result[3, 2] = argument[14];
      result[3, 3] = argument[15];
    break;
    default:
      show_error("Expected 1, 4, 9 or 16 arguments, got " + string(argument_count) + ".", true);
    break;
  }
  return result;
}

#define rnn_identity
/// @description rnn_identity(n)
/// @param n
{
  var M;
  for (var i = 0; i < argument0; i++) {
    for (var j = 0; j < argument0; j++) {
      M[i, j] = 0;
    }
  }
  for (var i = 0; i < argument0; i++) {
    M[i, i] = 1;
  }
  return M;
}

#define rnn_zero
/// @description rnn_zero(n)
/// @param n
{
  var M;
  for (var i = 0; i < argument0; i++) {
    for (var j = 0; j < argument0; j++) {
      M[i, j] = 0;
    }
  }
  return M;
}

#define r22_encode_string
/// @description r22_encode_string(M)
/// @param M
{
  return string_replace_all(
      string_format(argument0[0, 0], 15, 14)+","+
      string_format(argument0[0, 1], 15, 14)+";"+
      string_format(argument0[1, 0], 15, 14)+","+
      string_format(argument0[1, 1], 15, 14)
  , " ", "");
}

#define r22_decode_string
/// @description r22_decode_string(str)
/// @param str
{
  var str, pos, result;
  str = argument0;
  pos = string_pos(",", str);
  result[0, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  result[0, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[1, 0] = real(string_copy(str, 1, pos-1));
  result[1, 1] = real(string_delete(str, 1, pos));
  return result;
}

#define r22_decode_string_to
/// @description r22_decode_string_to(str, Mout)
/// @param str
/// @param Mout
{
  var str, pos, result;
  str = argument0;
  pos = string_pos(",", str);
  argument1[@ 0, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  argument1[@ 0, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 1, 0] = real(string_copy(str, 1, pos-1));
  argument1[@ 1, 1] = real(string_delete(str, 1, pos));
  return argument1;
}

#define r22_encode_base64
/// @description r22_encode_base64(M)
/// @param M
{
  var buffer = buffer_create(32, buffer_fixed, 1);
  buffer_write(buffer, buffer_f64, argument0[0, 0]);
  buffer_write(buffer, buffer_f64, argument0[0, 1]);
  buffer_write(buffer, buffer_f64, argument0[1, 0]);
  buffer_write(buffer, buffer_f64, argument0[1, 1]);
  var result = buffer_base64_encode(buffer, 0, 32);
  buffer_delete(buffer);
  return result;
}

#define r22_decode_base64
/// @description r22_decode_base64(enc)
/// @param enc
{
  var buffer = buffer_create(32, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  var result;
  result[0, 0] = buffer_read(buffer, buffer_f64);
  result[0, 1] = buffer_read(buffer, buffer_f64);
  result[1, 0] = buffer_read(buffer, buffer_f64);
  result[1, 1] = buffer_read(buffer, buffer_f64);
  buffer_delete(buffer);
  return result;
}

#define r22_decode_base64_to
/// @description r22_decode_base64_to(enc, Mout)
/// @param enc
/// @param Mout
{
  var buffer = buffer_create(32, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  argument1[@ 0, 0] = buffer_read(buffer, buffer_f64);
  argument1[@ 0, 1] = buffer_read(buffer, buffer_f64);
  argument1[@ 1, 0] = buffer_read(buffer, buffer_f64);
  argument1[@ 1, 1] = buffer_read(buffer, buffer_f64);
  buffer_delete(buffer);
  return argument1;
}

#define r33_encode_string
/// @description r33_encode_string(M)
/// @param M
{
  return string_replace_all(
      string_format(argument0[0, 0], 15, 14)+","+
      string_format(argument0[0, 1], 15, 14)+","+
      string_format(argument0[0, 2], 15, 14)+";"+
      string_format(argument0[1, 0], 15, 14)+","+
      string_format(argument0[1, 1], 15, 14)+","+
      string_format(argument0[1, 2], 15, 14)+";"+
      string_format(argument0[2, 0], 15, 14)+","+
      string_format(argument0[2, 1], 15, 14)+","+
      string_format(argument0[2, 2], 15, 14)
  , " ", "");
}

#define r33_decode_string
/// @description r33_decode_string(str)
/// @param str
{
  var str, pos, result;
  str = argument0;
  pos = string_pos(",", str);
  result[0, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[0, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  result[0, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[1, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[1, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  result[1, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[2, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[2, 1] = real(string_copy(str, 1, pos-1));
  result[2, 2] = real(string_delete(str, 1, pos));
  return result;
}

#define r33_decode_string_to
/// @description r33_decode_string_to(str, Mout)
/// @param str
/// @param Mout
{
  var str, pos, result;
  str = argument0;
  pos = string_pos(",", str);
  argument1[@ 0, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 0, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  argument1[@ 0, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 1, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 1, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  argument1[@ 1, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 2, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 2, 1] = real(string_copy(str, 1, pos-1));
  argument1[@ 2, 2] = real(string_delete(str, 1, pos));
  return argument1;
}

#define r33_encode_base64
/// @description r33_encode_base64(M)
/// @param M
{
  var buffer = buffer_create(72, buffer_fixed, 1);
  buffer_write(buffer, buffer_f64, argument0[0, 0]);
  buffer_write(buffer, buffer_f64, argument0[0, 1]);
  buffer_write(buffer, buffer_f64, argument0[0, 2]);
  buffer_write(buffer, buffer_f64, argument0[1, 0]);
  buffer_write(buffer, buffer_f64, argument0[1, 1]);
  buffer_write(buffer, buffer_f64, argument0[1, 2]);
  buffer_write(buffer, buffer_f64, argument0[2, 0]);
  buffer_write(buffer, buffer_f64, argument0[2, 1]);
  buffer_write(buffer, buffer_f64, argument0[2, 2]);
  var result = buffer_base64_encode(buffer, 0, 72);
  buffer_delete(buffer);
  return result;
}

#define r33_decode_base64
/// @description r33_decode_base64(enc)
/// @param enc
{
  var buffer = buffer_create(72, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  var result;
  result[0, 0] = buffer_read(buffer, buffer_f64);
  result[0, 1] = buffer_read(buffer, buffer_f64);
  result[0, 2] = buffer_read(buffer, buffer_f64);
  result[1, 0] = buffer_read(buffer, buffer_f64);
  result[1, 1] = buffer_read(buffer, buffer_f64);
  result[1, 2] = buffer_read(buffer, buffer_f64);
  result[2, 0] = buffer_read(buffer, buffer_f64);
  result[2, 1] = buffer_read(buffer, buffer_f64);
  result[2, 2] = buffer_read(buffer, buffer_f64);
  buffer_delete(buffer);
  return result;
}

#define r33_decode_base64_to
/// @description r33_decode_base64_to(enc, Mout)
/// @param enc
/// @param Mout
{
  var buffer = buffer_create(72, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  argument1[@ 0, 0] = buffer_read(buffer, buffer_f64);
  argument1[@ 0, 1] = buffer_read(buffer, buffer_f64);
  argument1[@ 0, 2] = buffer_read(buffer, buffer_f64);
  argument1[@ 1, 0] = buffer_read(buffer, buffer_f64);
  argument1[@ 1, 1] = buffer_read(buffer, buffer_f64);
  argument1[@ 1, 2] = buffer_read(buffer, buffer_f64);
  argument1[@ 2, 0] = buffer_read(buffer, buffer_f64);
  argument1[@ 2, 1] = buffer_read(buffer, buffer_f64);
  argument1[@ 2, 2] = buffer_read(buffer, buffer_f64);
  buffer_delete(buffer);
  return argument1;
}

#define r44_encode_string
/// @description r44_encode_string(M)
/// @param M
{
  return string_replace_all(
      string_format(argument0[0, 0], 15, 14)+","+
      string_format(argument0[0, 1], 15, 14)+","+
      string_format(argument0[0, 2], 15, 14)+","+
      string_format(argument0[0, 3], 15, 14)+";"+
      string_format(argument0[1, 0], 15, 14)+","+
      string_format(argument0[1, 1], 15, 14)+","+
      string_format(argument0[1, 2], 15, 14)+","+
      string_format(argument0[1, 3], 15, 14)+";"+
      string_format(argument0[2, 0], 15, 14)+","+
      string_format(argument0[2, 1], 15, 14)+","+
      string_format(argument0[2, 2], 15, 14)+","+
      string_format(argument0[2, 3], 15, 14)+";"+
      string_format(argument0[3, 0], 15, 14)+","+
      string_format(argument0[3, 1], 15, 14)+","+
      string_format(argument0[3, 2], 15, 14)+","+
      string_format(argument0[3, 3], 15, 14)
  , " ", "");
}

#define r44_decode_string
/// @description r44_decode_string(str)
/// @param str
{
  var str, pos, result;
  str = argument0;
  pos = string_pos(",", str);
  result[0, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[0, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[0, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  result[0, 3] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[1, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[1, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[1, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  result[1, 3] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[2, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[2, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[2, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  result[2, 3] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[3, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[3, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  result[3, 2] = real(string_copy(str, 1, pos-1));
  result[3, 3] = real(string_delete(str, 1, pos));
  return result;
}

#define r44_decode_string_to
/// @description r44_decode_string_to(str, Mout)
/// @param str
/// @param Mout
{
  var str, pos, result;
  str = argument0;
  pos = string_pos(",", str);
  argument1[@ 0, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 0, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 0, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  argument1[@ 0, 3] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 1, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 1, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 1, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  argument1[@ 1, 3] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 2, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 2, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 2, 2] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(";", str);
  argument1[@ 2, 3] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 3, 0] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 3, 1] = real(string_copy(str, 1, pos-1));
  str = string_delete(str, 1, pos);
  pos = string_pos(",", str);
  argument1[@ 3, 2] = real(string_copy(str, 1, pos-1));
  argument1[@ 3, 3] = real(string_delete(str, 1, pos));
  return argument1;
}

#define r44_encode_base64
/// @description r44_encode_base64(M)
/// @param M
{
  var buffer = buffer_create(128, buffer_fixed, 1);
  buffer_write(buffer, buffer_f64, argument0[0, 0]);
  buffer_write(buffer, buffer_f64, argument0[0, 1]);
  buffer_write(buffer, buffer_f64, argument0[0, 2]);
  buffer_write(buffer, buffer_f64, argument0[0, 3]);
  buffer_write(buffer, buffer_f64, argument0[1, 0]);
  buffer_write(buffer, buffer_f64, argument0[1, 1]);
  buffer_write(buffer, buffer_f64, argument0[1, 2]);
  buffer_write(buffer, buffer_f64, argument0[1, 3]);
  buffer_write(buffer, buffer_f64, argument0[2, 0]);
  buffer_write(buffer, buffer_f64, argument0[2, 1]);
  buffer_write(buffer, buffer_f64, argument0[2, 2]);
  buffer_write(buffer, buffer_f64, argument0[2, 3]);
  buffer_write(buffer, buffer_f64, argument0[3, 0]);
  buffer_write(buffer, buffer_f64, argument0[3, 1]);
  buffer_write(buffer, buffer_f64, argument0[3, 2]);
  buffer_write(buffer, buffer_f64, argument0[3, 3]);
  var result = buffer_base64_encode(buffer, 0, 128);
  buffer_delete(buffer);
  return result;
}

#define r44_decode_base64
/// @description r44_decode_base64(enc)
/// @param enc
{
  var buffer = buffer_create(128, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  var result;
  result[0, 0] = buffer_read(buffer, buffer_f64);
  result[0, 1] = buffer_read(buffer, buffer_f64);
  result[0, 2] = buffer_read(buffer, buffer_f64);
  result[0, 3] = buffer_read(buffer, buffer_f64);
  result[1, 0] = buffer_read(buffer, buffer_f64);
  result[1, 1] = buffer_read(buffer, buffer_f64);
  result[1, 2] = buffer_read(buffer, buffer_f64);
  result[1, 3] = buffer_read(buffer, buffer_f64);
  result[2, 0] = buffer_read(buffer, buffer_f64);
  result[2, 1] = buffer_read(buffer, buffer_f64);
  result[2, 2] = buffer_read(buffer, buffer_f64);
  result[2, 3] = buffer_read(buffer, buffer_f64);
  result[3, 0] = buffer_read(buffer, buffer_f64);
  result[3, 1] = buffer_read(buffer, buffer_f64);
  result[3, 2] = buffer_read(buffer, buffer_f64);
  result[3, 3] = buffer_read(buffer, buffer_f64);
  buffer_delete(buffer);
  return result;
}

#define r44_decode_base64_to
/// @description r44_decode_base64_to(enc, Mout)
/// @param enc
/// @param Mout
{
  var buffer = buffer_create(128, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  argument1[@ 0, 0] = buffer_read(buffer, buffer_f64);
  argument1[@ 0, 1] = buffer_read(buffer, buffer_f64);
  argument1[@ 0, 2] = buffer_read(buffer, buffer_f64);
  argument1[@ 0, 3] = buffer_read(buffer, buffer_f64);
  argument1[@ 1, 0] = buffer_read(buffer, buffer_f64);
  argument1[@ 1, 1] = buffer_read(buffer, buffer_f64);
  argument1[@ 1, 2] = buffer_read(buffer, buffer_f64);
  argument1[@ 1, 3] = buffer_read(buffer, buffer_f64);
  argument1[@ 2, 0] = buffer_read(buffer, buffer_f64);
  argument1[@ 2, 1] = buffer_read(buffer, buffer_f64);
  argument1[@ 2, 2] = buffer_read(buffer, buffer_f64);
  argument1[@ 2, 3] = buffer_read(buffer, buffer_f64);
  argument1[@ 3, 0] = buffer_read(buffer, buffer_f64);
  argument1[@ 3, 1] = buffer_read(buffer, buffer_f64);
  argument1[@ 3, 2] = buffer_read(buffer, buffer_f64);
  argument1[@ 3, 3] = buffer_read(buffer, buffer_f64);
  buffer_delete(buffer);
  return argument1;
}

#define rmn_clone
/// @description rmn_clone(M)
/// @param M
{
  var M_new, M_height, M_width;
  M_height = array_height_2d(argument0);
  M_width = array_length_2d(argument0, 0);
  for (var i = 0; i < M_height; i++) {
    for (var j = 0; j < M_width; j++) {
      M_new[i, j] = argument0[i, j];
    }
  }
  return M_new;
}

#define rmn_clone_to
/// @description rmn_clone_to(M, Mout)
/// @param M
/// @param Mout
{
  var M_height, M_width;
  M_height = array_height_2d(argument0);
  M_width = array_length_2d(argument0, 0);
  for (var i = 0; i < M_height; i++) {
    for (var j = 0; j < M_width; j++) {
      argument1[@ i, j] = argument0[i, j];
    }
  }
  return argument1;
}

#define rmn_add
/// @description rmn_add(M1, M2)
/// @param M1
/// @param M2
{
  var result;
  var M_height = array_height_2d(argument0),
      M_width = array_length_2d(argument0, 0);
  for (var i = 0; i < M_height; i++) {
    for (var j = 0; j < M_width; j++) {
      result[i, j] = argument0[i, j]+argument1[i, j];
    }
  }
  return result;
}

#define rmn_add_to
/// @description rmn_add_to(M1, M2, Mout)
/// @param M1
/// @param M2
/// @param Mout
{
  var M_height = array_height_2d(argument0),
      M_width = array_length_2d(argument0, 0);
  for (var i = 0; i < M_height; i++) {
    for (var j = 0; j < M_width; j++) {
      argument2[@ i, j] = argument0[i, j]+argument1[i, j];
    }
  }
  return argument2;
}

#define rmn_subtract
/// @description rmn_subtract(M1, M2)
/// @param M1
/// @param M2
{
  var result;
  var M_height = array_height_2d(argument0),
      M_width = array_length_2d(argument0, 0);
  for (var i = 0; i < M_height; i++) {
    for (var j = 0; j < M_width; j++) {
      result[i, j] = argument0[i, j]-argument1[i, j];
    }
  }
  return result;
}

#define rmn_subtract_to
/// @description rmn_subtract_to(M1, M2, Mout)
/// @param M1
/// @param M2
/// @param Mout
{
  var M_height = array_height_2d(argument0),
      M_width = array_length_2d(argument0, 0);
  for (var i = 0; i < M_height; i++) {
    for (var j = 0; j < M_width; j++) {
      argument2[@ i, j] = argument0[i, j]-argument1[i, j];
    }
  }
  return argument2;
}

#define rmn_scale
/// @description rmn_scale(M, r)
/// @param M
/// @param r
{
  var result;
  var M_height = array_height_2d(argument0),
      M_width = array_length_2d(argument0, 0);
  for (var i = 0; i < M_height; i++) {
    for (var j = 0; j < M_width; j++) {
      result[i, j] = argument0[i, j]*argument1;
    }
  }
  return result;
}

#define rmn_scale_to
/// @description rmn_scale_to(M, r, Mout)
/// @param M
/// @param r
/// @param Mout
{
  var M_height = array_height_2d(argument0),
      M_width = array_length_2d(argument0, 0);
  for (var i = 0; i < M_height; i++) {
    for (var j = 0; j < M_width; j++) {
      argument2[@ i, j] = argument0[i, j]*argument1;
    }
  }
  return argument2;
}

#define rmn_transpose
/// @description rmn_transpose(M)
/// @param M
{
  var result;
  var m = array_height_2d(argument0),
      n = array_length_2d(argument0, 0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < m; j++) {
      result[i, j] = argument0[j, i];
    }
  }
  return result;
}

#define rmn_transpose_to
/// @description rmn_transpose_to(M, Mout)
/// @param M
/// @param Mout
{
  var result;
  var m = array_height_2d(argument0),
      n = array_length_2d(argument0, 0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < m; j++) {
      result[i, j] = argument0[j, i];
    }
  }
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < m; j++) {
      argument1[@ i, j] = result[i, j];
    }
  }
  return argument1;
}

#define rmn_multiply
/// @description rmn_multiply(M1, M2)
/// @param M1
/// @param M2
{
  var result;
  var m = array_height_2d(argument0),
      q = array_height_2d(argument1),
      n = array_length_2d(argument1, 0);
  for (var i = 0; i < m; i++) {
    for (var j = 0; j < n; j++) {
      result[i, j] = 0;
      for (var k = 0; k < q; k++) {
        result[i, j] += argument0[i, k]*argument1[k, j];
      }
    }
  }
  return result;
}

#define rmn_multiply_to
/// @description rmn_multiply_to(M1, M2, Mout)
/// @param M1
/// @param M2
/// @param Mout
{
  var result;
  var m = array_height_2d(argument0),
      q = array_height_2d(argument1),
      n = array_length_2d(argument1, 0);
  for (var i = 0; i < m; i++) {
    for (var j = 0; j < n; j++) {
      result[i, j] = 0;
      for (var k = 0; k < q; k++) {
        result[i, j] += argument0[i, k]*argument1[k, j];
      }
    }
  }
  for (var i = 0; i < m; i++) {
    for (var j = 0; j < n; j++) {
      argument2[@ i, j] = result[i, j];
    }
  }
  return argument2;
}

#define rmn_transform
/// @description rmn_transform(M, v)
/// @param M
/// @param v
{
  var result;
  var m = array_height_2d(argument0),
      n = array_length_1d(argument1);
  for (var i = 0; i < m; i++) {
    result[i] = 0;
    for (var j = 0; j < n; j++) {
      result[i] += argument0[i, j]*argument1[j];
    }
  }
  return result;
}

#define rmn_transform_to
/// @description rmn_transform_to(M, v, vout)
/// @param M
/// @param v
/// @param vout
{
  var result;
  var m = array_height_2d(argument0),
      n = array_length_1d(argument1);
  for (var i = 0; i < m; i++) {
    result[i] = 0;
    for (var j = 0; j < n; j++) {
      result[i] += argument0[i, j]*argument1[j];
    }
  }
  for (var i = 0; i < m; i++) {
    argument2[@ i] = result[i];
  }
  return argument2
}

#define rmn_encode_string
/// @description rmn_encode_string(M)
/// @param M
{
  var result = "",
      m = array_height_2d(argument0),
      n = array_length_2d(argument0, 0);
  for (var i = 0; i < m; i++) {
    for (var j = 0; j < n; j++) {
      if (j > 0) result += ",";
      result += string_format(argument0[i, j], 15, 14);
    }
    if (i < m-1) {
      result += ";";
    }
  }
  return string_replace_all(result, " ", "");
}

#define rmn_decode_string
/// @description rmn_decode_string(str)
/// @param str
{
  var str = argument0,
      i_dim = string_count(";", str);
  var cpos, spos, rowstr, j_dim, result;
  for (var i = 0; i < i_dim; i++) {
    spos = string_pos(";", str);
    rowstr = string_copy(str, 1, spos-1);
    str = string_delete(str, 1, spos);
    j_dim = string_count(",", rowstr);
    for (var j = 0; j < j_dim; j++) {
      cpos = string_pos(",", rowstr);
      result[i, j] = real(string_copy(rowstr, 1, cpos-1));
      rowstr = string_delete(rowstr, 1, cpos);
    }
    result[i, j_dim] = real(rowstr);
  }
  for (var j = 0; j < j_dim; j++) {
    cpos = string_pos(",", str);
    result[i_dim, j] = real(string_copy(str, 1, cpos-1));
    str = string_delete(str, 1, cpos);
  }
  result[i_dim, j_dim] = real(str);
  return result;
}

#define rmn_decode_string_to
/// @description rmn_decode_string_to(str, Mout)
/// @param str
/// @param Mout
{
  var str = argument0,
      i_dim = string_count(";", str);
  var cpos, spos, rowstr, j_dim;
  for (var i = 0; i < i_dim; i++) {
    spos = string_pos(";", str);
    rowstr = string_copy(str, 1, spos-1);
    str = string_delete(str, 1, spos);
    j_dim = string_count(",", rowstr);
    for (var j = 0; j < j_dim; j++) {
      cpos = string_pos(",", rowstr);
      argument1[@ i, j] = real(string_copy(rowstr, 1, cpos-1));
      rowstr = string_delete(rowstr, 1, cpos);
    }
    argument1[@ i, j_dim] = real(rowstr);
  }
  for (var j = 0; j < j_dim; j++) {
    cpos = string_pos(",", str);
    argument1[@ i_dim, j] = real(string_copy(str, 1, cpos-1));
    str = string_delete(str, 1, cpos);
  }
  argument1[@ i_dim, j_dim] = real(str);
  return argument1;
}

#define rmn_encode_base64
/// @description rmn_encode_base64(M)
/// @param M
{
  var m = array_height_2d(argument0),
      n = array_length_2d(argument0, 0),
      buffer = buffer_create(8*m*n, buffer_fixed, 1);
  for (var i = 0; i < m; i++) {
    for (var j = 0; j < n; j++) {
      buffer_write(buffer, buffer_f64, argument0[i, j]);
    }
  }
  var result = buffer_base64_encode(buffer, 0, 8*m*n);
  buffer_delete(buffer);
  return result;
}

#define rmn_decode_base64
/// @description rmn_decode_base64(enc, m, n)
/// @param enc
/// @param m
/// @param n
{
  var i_dim = argument1,
      j_dim = argument2,
      buffer = buffer_create(8*argument1*argument2, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  var result;
  for (var i = 0; i < i_dim; i++) {
    for (var j = 0; j < j_dim; j++) {
      result[i, j] = buffer_read(buffer, buffer_f64);
    }
  }
  buffer_delete(buffer);
  return result;
}

#define rmn_decode_base64_to
/// @description rmn_decode_base64_to(enc, m, n, Mout)
/// @param enc
/// @param m
/// @param n
/// @param Mout
{
  var i_dim = argument1,
      j_dim = argument2,
      buffer = buffer_create(8*argument1*argument2, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  var result;
  for (var i = 0; i < i_dim; i++) {
    for (var j = 0; j < j_dim; j++) {
      argument3[@ i, j] = buffer_read(buffer, buffer_f64);
    }
  }
  buffer_delete(buffer);
  return argument3;
}

#define rnn_clone
/// @description rnn_clone(M)
/// @param M
{
  var M_new, M_dim;
  M_dim = array_height_2d(argument0);
  for (var i = 0; i < M_dim; i++) {
    for (var j = 0; j < M_dim; j++) {
      M_new[i, j] = argument0[i, j];
    }
  }
  return M_new;
}

#define rnn_clone_to
/// @description rnn_clone_to(M, Mout)
/// @param M
/// @param Mout
{
  var M_dim;
  M_dim = array_height_2d(argument0);
  for (var i = 0; i < M_dim; i++) {
    for (var j = 0; j < M_dim; j++) {
      argument1[@ i, j] = argument0[i, j];
    }
  }
  return argument1;
}

#define rnn_add
/// @description rnn_add(M1, M2)
/// @param M1
/// @param M2
{
  var result;
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      result[i, j] = argument0[i, j]+argument1[i, j];
    }
  }
  return result;
}

#define rnn_add_to
/// @description rnn_add_to(M1, M2, Mout)
/// @param M1
/// @param M2
/// @param Mout
{
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      argument2[@ i, j] = argument0[i, j]+argument1[i, j];
    }
  }
  return argument2;
}

#define rnn_subtract
/// @description rnn_subtract(M1, M2)
/// @param M1
/// @param M2
{
  var result;
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      result[i, j] = argument0[i, j]-argument1[i, j];
    }
  }
  return result;
}

#define rnn_subtract_to
/// @description rnn_subtract_to(M1, M2, Mout)
/// @param M1
/// @param M2
/// @param Mout
{
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      argument2[@ i, j] = argument0[i, j]-argument1[i, j];
    }
  }
  return argument2;
}

#define rnn_scale
/// @description rnn_scale(M, r)
/// @param M
/// @param r
{
  var result;
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      result[i, j] = argument0[i, j]*argument1;
    }
  }
  return result;
}

#define rnn_scale_to
/// @description rnn_scale_to(M, r, Mout)
/// @param M
/// @param r
/// @param Mout
{
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      argument2[@ i, j] = argument0[i, j]*argument1;
    }
  }
  return argument2;
}

#define rnn_transpose
/// @description rnn_transpose(M)
/// @param M
{
  var result;
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      result[i, j] = argument0[j, i];
    }
  }
  return result;
}

#define rnn_transpose_to
/// @description rnn_transpose_to(M, Mout)
/// @param M
/// @param Mout
{
  var result, tmp;
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j <= i; j++) {
      tmp = argument0[i, j];
      argument1[@ i, j] = argument0[j, i];
      argument1[@ j, i] = tmp;
    }
  }
  return argument1;
}

#define rnn_multiply
/// @description rnn_multiply(M1, M2)
/// @param M1
/// @param M2
{
  var result;
  var m = array_height_2d(argument0),
      n = array_length_2d(argument1, 0);
  for (var i = 0; i < m; i++) {
    for (var j = 0; j < n; j++) {
      result[i, j] = 0;
      for (var k = 0; k < m; k++) {
        result[i, j] += argument0[i, k]*argument1[k, j];
      }
    }
  }
  return result;
}

#define rnn_multiply_to
/// @description rnn_multiply_to(M1, M2, Mout)
/// @param M1
/// @param M2
/// @param Mout
{
  var result;
  var m = array_height_2d(argument0),
      n = array_length_2d(argument1, 0);
  for (var i = 0; i < m; i++) {
    for (var j = 0; j < n; j++) {
      result[i, j] = 0;
      for (var k = 0; k < m; k++) {
        result[i, j] += argument0[i, k]*argument1[k, j];
      }
    }
  }
  for (var i = 0; i < m; i++) {
    for (var j = 0; j < n; j++) {
      argument2[@ i, j] = result[i, j];
    }
  }
  return argument2;
}

#define rnn_transform
/// @description rnn_transform(M, v)
/// @param M
/// @param v
{
  var result;
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    result[i] = 0;
    for (var j = 0; j < n; j++) {
      result[i] += argument0[i, j]*argument1[j];
    }
  }
  return result;
}

#define rnn_transform_to
/// @description rnn_transform_to(M, v, vout)
/// @param M
/// @param v
/// @param vout
{
  var result;
  var n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    result[i] = 0;
    for (var j = 0; j < n; j++) {
      result[i] += argument0[i, j]*argument1[j];
    }
  }
  for (var i = 0; i < n; i++) {
    argument2[@ i] = result[i];
  }
  return argument2;
}

#define rnn_invert
/// @description rnn_invert(M)
/// @param M
//This uses the Gauss-Jordan method with row pivoting for finding a general inverse without external dependencies
{
  //Find dimensions, start with original=M, result=identity
  var n = array_height_2d(argument0);
  var original, result;
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      original[i, j] = argument0[i, j];
      result[i, j] = 0;
    }
  }
  for (var i = 0; i < n; i++) {
    result[i, i] = 1;
  }
  //For each row
  for (var i = 0; i < n; i++) {
    //Find highest row among i through n-1 by absolute value of its ith entry
    var highest_row_i = i,
        highest_row_abs = abs(original[i, i]),
        current_row_abs;
    for (var ii = i+1; ii < n; ii++) {
      current_row_abs = abs(original[ii, i]);
      if (current_row_abs > highest_row_abs) {
        highest_row_i = ii;
        highest_row_abs = current_row_abs;
      }
    }
    //It is singular if the entire remaining column is 0
    if (highest_row_abs == 0) {
      return undefined;
    }
    //Swap the row on both the original and the result
    if (i != highest_row_i) {
      for (var j = 0; j < n; j++) {
        var tmp;
        tmp = original[i, j];
        original[i, j] = original[highest_row_i, j];
        original[highest_row_i, j] = tmp;
        tmp = result[i, j];
        result[i, j] = result[highest_row_i, j];
        result[highest_row_i, j] = tmp;
      }
    }
    //Scale down ith row on both the original and the result
    var scale_factor = original[i, i];
    for (var j = i+1; j < n; j++) {
      original[i, j] /= scale_factor;
    }
    for (var j = 0; j < n; j++) {
      result[i, j] /= scale_factor;
    }
    original[i, i] = 1;
    //Do row subtraction on every other row, on the original and the result
    for (var ii = 0; ii < n; ii++) {
      if (ii != i) {
        var factor = original[ii, i];
        for (var j = i+1; j < n; j++) {
          original[ii, j] -= factor*original[i, j];
        }
        for (var j = 0; j < n; j++) {
          result[ii, j] -= factor*result[i, j];
        }
        original[ii, i] = 0;
      }
    }
  }
  //Done
  return result;
}

#define rnn_invert_to
/// @description rnn_invert_to(M, Mout)
/// @param M
/// @param Mout
//This uses the Gauss-Jordan method with row pivoting for finding a general inverse without external dependencies
{
  //Find dimensions, start with original=M, result=identity
  var n = array_height_2d(argument0);
  var original, result;
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      original[i, j] = argument0[i, j];
      result[i, j] = 0;
    }
  }
  for (var i = 0; i < n; i++) {
    result[i, i] = 1;
  }
  //For each row
  for (var i = 0; i < n; i++) {
    //Find highest row among i through n-1 by absolute value of its ith entry
    var highest_row_i = i,
        highest_row_abs = abs(original[i, i]),
        current_row_abs;
    for (var ii = i+1; ii < n; ii++) {
      current_row_abs = abs(original[ii, i]);
      if (current_row_abs > highest_row_abs) {
        highest_row_i = ii;
        highest_row_abs = current_row_abs;
      }
    }
    //It is singular if the entire remaining column is 0
    if (highest_row_abs == 0) {
      return undefined;
    }
    //Swap the row on both the original and the result
    if (i != highest_row_i) {
      for (var j = 0; j < n; j++) {
        var tmp;
        tmp = original[i, j];
        original[i, j] = original[highest_row_i, j];
        original[highest_row_i, j] = tmp;
        tmp = result[i, j];
        result[i, j] = result[highest_row_i, j];
        result[highest_row_i, j] = tmp;
      }
    }
    //Scale down ith row on both the original and the result
    var scale_factor = original[i, i];
    for (var j = i+1; j < n; j++) {
      original[i, j] /= scale_factor;
    }
    for (var j = 0; j < n; j++) {
      result[i, j] /= scale_factor;
    }
    original[i, i] = 1;
    //Do row subtraction on every other row, on the original and the result
    for (var ii = 0; ii < n; ii++) {
      if (ii != i) {
        var factor = original[ii, i];
        for (var j = i+1; j < n; j++) {
          original[ii, j] -= factor*original[i, j];
        }
        for (var j = 0; j < n; j++) {
          result[ii, j] -= factor*result[i, j];
        }
        original[ii, i] = 0;
      }
    }
  }
  //Done --- copy result to output
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      argument1[@ i, j] = result[i, j];
    }
  }
  return argument1;
}

#define rnn_encode_string
/// @description rnn_encode_string(M)
/// @param M
{
  var result = "",
      n = array_height_2d(argument0);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      if (j > 0) result += ",";
      result += string_format(argument0[i, j], 15, 14);
    }
    if (i < n-1) {
      result += ";";
    }
  }
  return string_replace_all(result, " ", "");
}

#define rnn_decode_string
/// @description rnn_decode_string(str)
/// @param str
{
  var str = argument0,
      n_dim = string_count(";", str);
  var cpos, spos, rowstr, result;
  for (var i = 0; i < n_dim; i++) {
    spos = string_pos(";", str);
    rowstr = string_copy(str, 1, spos-1);
    str = string_delete(str, 1, spos);
    for (var j = 0; j < n_dim; j++) {
      cpos = string_pos(",", rowstr);
      result[i, j] = real(string_copy(rowstr, 1, cpos-1));
      rowstr = string_delete(rowstr, 1, cpos);
    }
    result[i, n_dim] = real(rowstr);
  }
  for (var j = 0; j < n_dim; j++) {
    cpos = string_pos(",", str);
    result[n_dim, j] = real(string_copy(str, 1, cpos-1));
    str = string_delete(str, 1, cpos);
  }
  result[n_dim, n_dim] = real(str);
  return result;
}

#define rnn_decode_string_to
/// @description rnn_decode_string_to(str, Mout)
/// @param str
/// @param Mout
{
  var str = argument0,
      n_dim = string_count(";", str);
  var cpos, spos, rowstr;
  for (var i = 0; i < n_dim; i++) {
    spos = string_pos(";", str);
    rowstr = string_copy(str, 1, spos-1);
    str = string_delete(str, 1, spos);
    for (var j = 0; j < n_dim; j++) {
      cpos = string_pos(",", rowstr);
      argument1[@ i, j] = real(string_copy(rowstr, 1, cpos-1));
      rowstr = string_delete(rowstr, 1, cpos);
    }
    argument1[@ i, n_dim] = real(rowstr);
  }
  for (var j = 0; j < n_dim; j++) {
    cpos = string_pos(",", str);
    argument1[@ n_dim, j] = real(string_copy(str, 1, cpos-1));
    str = string_delete(str, 1, cpos);
  }
  argument1[@ n_dim, n_dim] = real(str);
  return argument1;
}

#define rnn_encode_base64
/// @description rnn_encode_base64(M)
/// @param M
{
  var n = array_height_2d(argument0),
      buffer = buffer_create(8*n*n, buffer_fixed, 1);
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      buffer_write(buffer, buffer_f64, argument0[i, j]);
    }
  }
  var result = buffer_base64_encode(buffer, 0, 8*n*n);
  buffer_delete(buffer);
  return result;
}

#define rnn_decode_base64
/// @description rnn_decode_base64(enc, n)
/// @param enc
/// @param n
{
  var buffer = buffer_create(8*argument1*argument1, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  var result;
  for (var i = 0; i < argument1; i++) {
    for (var j = 0; j < argument1; j++) {
      result[i, j] = buffer_read(buffer, buffer_f64);
    }
  }
  buffer_delete(buffer);
  return result;
}

#define rnn_decode_base64_to
/// @description rnn_decode_base64_to(enc, n, Mout)
/// @param enc
/// @param n
/// @param Mout
{
  var buffer = buffer_create(8*argument1*argument1, buffer_fixed, 1);
  buffer_base64_decode_ext(buffer, argument0, 0);
  var result;
  for (var i = 0; i < argument1; i++) {
    for (var j = 0; j < argument1; j++) {
      argument2[@ i, j] = buffer_read(buffer, buffer_f64);
    }
  }
  buffer_delete(buffer);
  return argument2;
}
