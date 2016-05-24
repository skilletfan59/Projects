class Dragon

  def initialize name
    @name = name
    @asleep = false
    @stuffInBelly     = 10
    @stuffInIntestine =  0
    @tired = 10

    puts @name + ' is born.'
    puts "                           ^\\    ^                  
                          / \\\\  / \\                 
                         /.  \\\\/   \\      |\\___/|   
      *----*           / / |  \\\\    \\  __/  O  O\\   
      |   /          /  /  |   \\\\    \\_\\/  \\     \\     
     / /\\/         /   /   |    \\\\   _\\/    '@___@      
    /  /         /    /    |     \\\\ _\\/       |U
    |  |       /     /     |      \\\\\\/        |
    \\  |     /_     /      |       \\\\  )   \\ _|_
    \\   \\       ~-./_ _    |    .- ; (  \\_ _ _,\\'
    ~    ~.           .-~-.|.-*      _        {-,
     \\      ~-. _ .-~                 \\      /\\'
      \\                   }            {   .*
       ~.                 '-/        /.-~----.
         ~- _             /        >..----.\\\\\\ 
             ~ - - - - ^}_ _ _ _ _ _ _.-\\\\\\ "

  end

  def feed
    print %x{clear}
    puts 'You feed ' + @name + '.'
    puts "
                                  /   \\       
 _                        )      ((   ))     (
(@)                      /|\\      ))_((     /|\\
|-|                     / | \\    (/\\|/\\)   / | \\                      (@)
| | -------------------/--|-voV---\\'|'/--Vov-|--\\---------------------|-|
|-|                         '^`   (o o)  '^`                          | |
| |          _....._              '\\Y/'                               |-|
|-|      _.:`.--|--.`:._                                              | |
| |    .: .'\\o  | o /'. '.                     __.......__            |-|
|-|   // '.  \\ o|  /  o '.\\               ,-\"``           ``\"-.       | |
| |  //'._o'. \\ |o/ o_.-'o\\\\              |;------.-'      _.-'\\      |-|
|-|  || o '-.'.\\|/.-' o   ||              ||______|`  ' ' `    |      | |
| |  ||--o--o-->|<o-----o-||              ||------|            |      |-|
|-|  \\\\  o _.-'/|\\'-._o  o//             _;|______|            |_     | |
| |   \\\\.-'  o/ |o\\ o '-.//            (```\"\"\"\"\"\"\"|            |``)   |-|
|-|    '.'.o / o|  \\ o.'.'             \\'._       '-.........-'_.'/   | |
| |      `-:/.__|__o\\:-'                '._`\"\"===........===\"\"`_.'    |-|
|-|         `\"--=--\"`                      ``\"\"\"==========\"\"\"``       | |
| |                                                                   |-|
|_|___________________________________________________________________| |
(@)              l   /\\ /         ( (       \\ /\\   l                `\\|-|
                 l /   V           \\ \\       V   \\ l                  (@)
                 l/                _) )_          \\I
                                   '\\ /'"
    puts
    puts "#{@name} really enjoyed their meal. #{@name} is now full."
    @stuffInBelly = 10
    passageOfTime
  end

  def walk
    print %x{clear}
    puts 'You walk ' + @name + '.'
    puts "    @@@@@@@@@@@@@@@@@@@@@**^^\"\"~~~\"^@@^*@*@@**@@@@@@@@@
    @@@@@@@@@@@@@*^^'\"~   , - ' '; ,@@b. '  -e@@@@@@@@@
    @@@@@@@@*^\"~      . '     . ' ,@@@@(  e@*@@@@@@@@@@
    @@@@@^~         .       .   ' @@@@@@, ~^@@@@@@@@@@@
    @@@~ ,e**@@*e,  ,e**e, .    ' '@@@@@@e,  \"*@@@@@'^@
    @',e@@@@@@@@@@ e@@@@@@       ' '*@@@@@@    @@@'   0
    @@@@@@@@@@@@@@@@@@@@@',e,     ;  ~^*^'    ;^~   ' 0
    @@@@@@@@@@@@@@@^\"\"^@@e@@@   .'           ,'   .'  @
    @@@@@@@@@@@@@@'    '@@@@@ '         ,  ,e'  .    ;@
    @@@@@@@@@@@@@' ,&&,  ^@*'     ,  .  i^\"@e, ,e@e  @@
    @@@@@@@@@@@@' ,@@@@,          ;  ,& !,,@@@e@@@@ e@@
    @@@@@,~*@@*' ,@@@@@@e,   ',   e^~^@,   ~'@@@@@@,@@@
    @@@@@@, ~\" ,e@@@@@@@@@*e*@*  ,@e  @@\"\"@e,,@@@@@@@@@
    @@@@@@@@ee@@@@@@@@@@@@@@@\" ,e@' ,e@' e@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@\" ,@\" ,e@@e,,@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@~ ,@@@,,0@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@,,@@@@@@@@@@@@@@@@@@@@@@@@@
    \"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\""
    @stuffInIntestine = 0
    puts
    puts "#{@name} plays around in the grass and chases other people, then goes potty."
    passageOfTime
  end

  def putToBed
    print %x{clear}
    puts 'You put ' + @name + ' to bed.'
    @asleep = true
    @tired = 10
    puts "
         _________,---------.____------.___
        /_______    `--._______  `--.____ \\\\
         /__.-' `-----.____    `--.____\\\\`_/_
         ,'       ___      `---.___ ___//    `-.
        /     _.-'   )'           ``---'     \\  \\
       |     /       |           . '             |
      /    /     /   |          '    ___  )   |  |
      |   |     |  _/` _        ` _,' _ `/) '    |
       \\_  `--._\\__`--'_\\-___ _,-'   '-`  ___   _/
         `---.____ `--.__-_  /_)____,  __/  ,`-'
                  `------__>  `-------(/(/-'-\\)\\)"
    3.times do
      if @asleep
        passageOfTime
      end
      if @asleep
        puts @name + ' snores, filling the room with smoke.'
      end
    end
    if @asleep
      @asleep = false
      puts @name + ' wakes up slowly.'
      @tired = 10
    end
  end

  def toss
    print %x{clear}
    puts 'You toss ' + @name + ' up into the air.'
    puts "
                                                 /===-_---~~~~~~~~~------____
                                                |===-~___                _,-'
                 -==\\\\                         `//~\\\\   ~~~~`---.___.-~~
             ______-==|                         | |  \\\\           _-~`
       __--~~~  ,-/-==\\\\                        | |   `\\        ,'
    _-~       /'    |  \\\\                      / /      \\      /
  .'        /       |   \\                   /' /        \\   /'
 /  ____  /         |    \\`\\.__/-~~ ~ \\ _ _/'  /          \\/'
/-'~    ~~~~~---__  |     ~-/~         ( )   /'        _--~`
                  \\_|      /        _)   ;  ),   __--~~
                    '~~--_/      _-~/-  / \\   '-~ \\
                   {\\__--_/}    / \\\\_>- )<__\\      \\
                   /'   (_/  _-~  | |__>--<__|      | 
                  |0  0 _/) )-~     | |__>--<__|      |
                  / /~ ,_/       / /__>---<__/      |  
                 o o _//        /-~_>---<__-~      /
                 (^(~          /~_>---<__-      _-~              
                ,/|           /__>--<__/     _-~                 
             ,//('(          |__>--<__|     /                  .----_ 
            ( ( '))          |__>--<__|    |                 /' _---_~\\
         `-)) )) (           |__>--<__|    |               /'  /     ~\\`\\
        ,/,'//( (             \\__>--<__\\    \\            /'  //        ||
      ,( ( ((, ))              ~-__>--<_~-_  ~--____---~' _/'/        /'
    `~/  )` ) ,/|                 ~-_~>--<_/-__       __-~ _/ 
  ._-~//( )/ )) `                    ~~-'_/_/ /~~~~~~~__--~ 
   ;'( ')/ ,)(                              ~~~~~~~~~~ 
  ' ') '( (/
    '   '  `   "
    puts
    puts 'He giggles, which singes your eyebrows.'
    passageOfTime
  end

  def rock
    print %x{clear}
    puts 'You rock ' + @name + ' gently.'
    @asleep = true
    if @tired <= 8
      @tired += 2
    else
      @tired = 10
    end
    puts "                                  .      .
                             '    }\\    /{    `
                            /|\\   ) \\__/ (   /|\\
                           / | \\  (*\\  /*)  / | \\
                          /  |  \\_ \\    / _/  |  \\
                         (   |    \\|\\../|/    |   )
                         /   |     | VV |     |   \\
                        /    |    (______)    |    \\
                       /     |    (      )    |     \\
                      (      |    (______)    |      )
                       \\     |    (      )    |     /
                      /      |    (______)    |      \\
                     /       |    (      )    |       \\
                    /        |    (______)    |        \\
                    (        |    (      )    |        )
                     |    /\\ /~\\|T|\\/~\\/~\\/T\\/~\\ /\\   |
                     |  /   V   '|`   \\\\  '|`   V  \\  |
                     |/     `          ))       '    \\|
                     `                ((              '
                                       V "
    puts
    puts 'He briefly dozes off...'
    passageOfTime
    if @asleep
      @asleep = false
      puts '...but wakes when you stop.'
    end
  end

  private

  def hungry?
    @stuffInBelly <= 2
  end

  def poopy?
    @stuffInIntestine >= 8
  end

  def sleepy?
    @tired <=2
  end

  def passageOfTime
    if @stuffInBelly > 0
      @stuffInBelly     = @stuffInBelly     - 1
      @stuffInIntestine = @stuffInIntestine + 1
      @tired -= 1
    else
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts @name + ' is starving!  In desperation, he ate YOU!'
      break
    end

    if @stuffInIntestine >= 10
      @stuffInIntestine = 0
      puts
      puts 'Whoops!  ' + @name + ' had an accident...'
      puts
      puts "   ~\“_/\\_ \"~
 ~\“ (____) \”~
 ~\“(______) \”~
\“_(________)_\”~
(____________) \”"
      puts
      puts "Gross!! Now you have to clean up after #{@name}!"
      puts "Make sure you are paying better attention next time!"
    end

    if @tired <=0
      puts "#{@name} just passed out from exhaustion!"
      puts "#{@name} will not recover from this neglect and PETA came to save them."
      puts "You are not mature enough to own and take care of a pet, so now you don't have one!"
      break
    end

    if sleepy?
      puts "#{@name} yawns and blows fire on your shirt. He must be getting sleepy..."
    end

    if hungry?
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts @name + '\'s stomach grumbles...'
    end

    if poopy?
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts @name + ' does the potty dance...'
    end
  end

end
print %x{clear}
puts "Welcome to Virtual Dragon. First you need to name your new pet!"
print "What would you like your dragon to be named? "
name = gets.chomp.split(" ").each {|word| word.capitalize!}.join(" ")
pet = Dragon.new name
puts
puts "Congratulations! You know have a pet dragon!"
puts
puts "Now like every other pet you have to care for, you have to keep him happy and alive."
puts
puts "You do this by feeding them, walking them so they can go potty, toss them 
in the air to make them happy, rock them in a chair to calm them down,
and of course they need their sleep too so you have to put them to bed."
puts
puts "In order to interact with your pet dragon all you have to do is type in: 
Feed, Walk, Toss, Rock, or Bed to do that activity."
inputs = ["feed", "walk", "toss", "rock", "bed", "exit"]
input = nil
while input != "exit"
  input = "nothing"
  until inputs.include?(input) == true do
    puts
    puts "You can only feed, walk, toss, rock, or bed your dragon,"
    print "What would you like to do with #{name}? "
    input = gets.chomp.downcase
  end
  if input == "exit"
    print %x{clear}
    break
  elsif input == "feed"
    pet.feed
  elsif input == "walk"
    pet.walk
  elsif input == "toss"
    pet.toss
  elsif input == "rock"
    pet.rock
  elsif input == "bed"
    pet.putToBed
  end
end