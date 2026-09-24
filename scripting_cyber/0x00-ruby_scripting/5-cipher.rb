#!/usr/bin/env ruby
class CaesarCipher
  def initialize(shift)
    @shift = shift
  end

  def encrypt(message)
    cipher(message, @shift)
  end

  def decrypt(message)
    cipher(message, -@shift)
  end

  private

  def cipher(message, shift)
    message.chars.map { |char| shift_char(char, shift) }.join
  end

  def shift_char(char, shift)
    return char unless char =~ /[a-zA-Z]/

    base = char == char.upcase ? 'A'.ord : 'a'.ord
    ((char.ord - base + shift) % 26 + base).chr
  end
end
