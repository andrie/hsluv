#include <cpp11.hpp>
using namespace cpp11;

#include "hsluv.h"
[[cpp11::register]]
// wrap rgb2hsluv and expose to R
// takes a numeric vector as input and returns a numeric vector of length 3
doubles cpp_rgb_to_hsluv(doubles rgb) {
  if (rgb.size() != 3) stop("Input vector must be of length 3");
  double h, s, l;
  rgb2hsluv(rgb[0], rgb[1], rgb[2], &h, &s, &l);
  return writable::doubles{h, s, l};
}


[[cpp11::register]]
// wrap hsluv2rgb and expose to R
// takes a numeric vector as input and returns a numeric vector of length 3
doubles cpp_hsluv_to_rgb(doubles hsluv) {
  if (hsluv.size() != 3) stop("Input vector must be of length 3");
  double r, g, b;
  hsluv2rgb(hsluv[0], hsluv[1], hsluv[2], &r, &g, &b);
  return writable::doubles{r, g, b};
}


#include <string>
#include <sstream>
#include <iomanip>

[[cpp11::register]]
doubles cpp_hex_to_rgb(std::string hex) {
  if (hex.size() == 4 && hex[0] == '#') {
    // Expand short format: #rgb -> #rrggbb
    hex = "#" + std::string(2, hex[1]) + std::string(2, hex[2]) + std::string(2, hex[3]);
  }
  if (hex.size() != 7 || hex[0] != '#') stop("Hex string must be in format #RRGGBB");
  int r, g, b;
  std::istringstream(hex.substr(1,2)) >> std::hex >> r;
  std::istringstream(hex.substr(3,2)) >> std::hex >> g;
  std::istringstream(hex.substr(5,2)) >> std::hex >> b;
  double dr = static_cast<double>(r) / 255.0;
  double dg = static_cast<double>(g) / 255.0;
  double db = static_cast<double>(b) / 255.0;
  return writable::doubles{dr, dg, db};
}


[[cpp11::register]]
std::string cpp_rgb_to_hex(doubles rgb) {
  if (rgb.size() != 3) stop("Input vector must be of length 3");
  int r = std::max(0, std::min(255, static_cast<int>(rgb[0] * 255.0 + 0.5)));
  int g = std::max(0, std::min(255, static_cast<int>(rgb[1] * 255.0 + 0.5)));
  int b = std::max(0, std::min(255, static_cast<int>(rgb[2] * 255.0 + 0.5)));
  std::ostringstream oss;
  oss << "#" << std::setw(2) << std::setfill('0') << std::hex << std::uppercase << r
      << std::setw(2) << std::setfill('0') << std::hex << std::uppercase << g
      << std::setw(2) << std::setfill('0') << std::hex << std::uppercase << b;
  return oss.str();
}
  


