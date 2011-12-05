desc "Shortens limitations descriptions"
def form_qa_array!(dir)
  #loop through directory
  @qa_array = []
  question = ""
  #get rid of this variable when you're done!
  temp_file_count = 1
  Dir.foreach(dir) do |file|
    
    if temp_file_count > 16
      break
    end
    
    if file.include? "txt"
      puts dir + "/" + file
      myfile = File.open(dir + "/" + file)
       
      #loop through each line in the file
      myfile.each do |line|
        if line[0].to_i != 0
          question_with_numbers = line.chomp.to_s
          #get rid of the question number
          begin
            number_and_spaces = question_with_numbers.match /^[\d]*\.[\s]*/
          rescue
            next
          end
          if number_and_spaces
            question = question_with_numbers[(0 + number_and_spaces.to_s.length)..-1]
          end
        end
        if line.include? "ANS"
          begin
            answer_with_prefix = line.chomp.to_s
            semicolon_location = answer_with_prefix.index(":")
            answer = answer_with_prefix[(semicolon_location + 1)..-1].to_s.strip!
          rescue
            next
          end
          @qa_array << [question, answer]
        end
      end
    end
    temp_file_count += 1
  end
end

def add_questions_to_database!
  Question.all.each do |q|
    q.destroy
  end
  @qa_array.each do |qa_pair|
    begin
      Question.create!({:question => "#{qa_pair[0]}", :answer => "#{qa_pair[1]}", :num => "#{@question_count}"})
      @question_count += 1
    rescue
      next
    end
  end
end

task :store_questions => :environment do
  @question_count = 0
  form_qa_array!("public/data")
  add_questions_to_database!

  total = @question_count
  puts "#{total} questions stored!"
end