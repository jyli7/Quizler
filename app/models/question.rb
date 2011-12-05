class Question
  include MongoMapper::Document
  
  key :question, String, :required => true
  key :answer, String, :required => true
  key :num, String, :required => true
  
  has_many :user_answers
  
  def truncate_expression(expression, ending)
    if expression.include? ending
      stop_pt = expression.index(ending)
      expression = expression[0...stop_pt]
      return expression
    else
      return nil
    end
  end

  def check_answer(input, answer)
    input = input.downcase
    full_answer = answer

    possible_endings = ["(accept", "[accept", "[prompt", "(prompt", "(also acceptable"]

    for ending in possible_endings
      answer = truncate_expression(answer, ending) if truncate_expression(answer, ending) != nil
    end

    #set up threshold and check match against that threshold
    threshold = 0.5
    total_char_in_answer = answer.length.to_f
    char_match = 0
    answer.each_char do |c|
      if input.include? c.downcase
        char_match += 1
        input.delete! c.downcase
      end
    end

    match_pct = char_match/total_char_in_answer
    if match_pct > threshold
      correct = true
    else
      correct = false
    end  

    if correct
      puts "\nCORRECT!"
      puts "The full answer was: #{full_answer}"
      return correct
    else
      puts "\nSorry, incorrect."
      puts "The answer was: #{full_answer}"
      return correct
    end
  end

  def read_out_loud(to_read, sleep_time)
    to_read = to_read.split(" ")
    stop = false
    finished_reading = false
    listen_for_buzz = Thread.new do
      if finished_reading
        break
      end
      gets
      stop = true
    end
    to_read.each do |c|
      if stop
        puts "BUZZZZZ!"
        # STDOUT.flush
        break
      end    
      print c, " "    
      sleep(sleep_time)
    end
    listen_for_buzz.kill
    sleep(sleep_time)
    print "\n"
  end

  def self.gimme_rand_question
    question_count = Question.all.count
    Question.find_by_num("#{rand(question_count).to_s}")
  end
    
  # #Start user interaction here
  # questions_correct = 0 
  # questions_asked = 0
  # while true
  #   puts "---------"
  #   puts "QUESTION:"
  #   question_answered_correctly = false
  #   @qa_pair = @coll.find("num" => "#{rand(coll_total).to_s}")
  #   @qa_pair.each do |row|
  #     question = row["question"]
  #     answer = row["answer"]
  #     read_out_loud(question, 0.25)
  #     print "What is your answer? "
  #     #following line is for debugging
  #     # print "The answer is: #{answer}", "\n"
  #     user_answer = gets.chomp!
  #     user_correct = check_answer(user_answer, answer)
  # 
  #     #keep track of score
  #     if user_correct
  #       questions_correct += 1
  #       question_answered_correctly = true
  #     end
  #     questions_asked += 1
  #   end
  #   print "Score: ", questions_correct.to_s, "/", questions_asked.to_s,  " answered correctly so far", "\n"  
  #   print "Hit [enter] to continue (or enter 'r' to reverse the verdict): "
  #   if gets.chomp! == "r"
  #     #reverse_verdict
  #     if question_answered_correctly == true
  #       questions_correct -= 1
  #       puts "\nVerdict reversed! Point deducted."
  #     else
  #       questions_correct += 1
  #       puts "\nVerdict reversed! Point added."
  #     end
  #     print "Score update: ", questions_correct.to_s, "/", questions_asked.to_s,  " answered correctly so far", "\n"
  #     print "Hit [enter] to continue"
  #     gets
  #   end
  # end
end
