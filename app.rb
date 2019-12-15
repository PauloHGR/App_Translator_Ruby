require 'rest-client'
require 'json'
require_relative 'text'
require_relative 'translator'

print "Insert text: "
text = gets.chomp
print "Enter current language: "
current_lang = gets.chomp
print "Enter the language to be translate: "
translation_lang = gets.chomp

attribute = Text.new
attribute.text = text
attribute.current_lang = current_lang
attribute.translation_lang = translation_lang

translator = Translator.new(attribute)
translator.text_final