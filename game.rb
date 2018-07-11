class Game
  attr_accessor :status, :errors, :letters, :bad_letters, :good_letters

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end

    return slovo.encode('UTF-8').split("")
  end

  def next_step(letter)
    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(letter) || @bad_letters.include?(letter)
      return
    end

    if (
      @letters.include?(letter) ||
      (letter == "е" && @letters.include?("ё")) ||
      (letter == "и" && @letters.include?("й")) ||
      (letter == "ё" && @letters.include?("е")) ||
      (letter == "й" && @letters.include?("и"))
    )

      @good_letters << letter
      
      if letter == "и"
        @good_letters << "й"
      end

      if letter == "й"
        @good_letters << "и"
      end

      if letter == "е"
        @good_letters << "ё"
      end

      if letter == "ё"
        @good_letters << "е"
      end
      
      if (@letters - @good_letters).empty?
        @status = 1
      end 
    else 
      @bad_letters << letter
      
      @errors += 1
      
      if @errors >=7
        @status = -1 
      end
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    next_step(letter.downcase)
  end
end
