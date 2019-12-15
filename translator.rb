class Translator < Text

    def initialize(attribute)
        @attribute = attribute
    end

    def text_final
        payload = {'key': 'trnsl.1.1.20191119T002836Z.4cbd7d1e205f02d6.eda65f98833430a4d1c428f2f41651a5e247c733', 
        'text': @attribute.text, 'lang': @attribute.current_lang+'-'+@attribute.translation_lang}

        # Call to the translation API
        begin
            resp = RestClient.post('https://translate.yandex.net/api/v1.5/tr.json/translate', payload, content_type: 'application/x-www-form-urlencoded')
        rescue
            puts "Error translating."
            exit
        end
        #Conversion of API Response to JSON
        data = JSON.parse(resp.body)

        puts "Translation #{@attribute.current_lang}-#{@attribute.translation_lang}: #{data['text']}"

        write_data(@attribute.text, data['text'].join)
    end

    private
    def write_data(original_text, translate_text)
        time = Time.now
        File.open(time.strftime('%d-%m-%y_%H:%M'),'w') do |line|
            line.write("#{original_text} => #{translate_text}") 
        end  
        puts "Saved data!"
    end
end