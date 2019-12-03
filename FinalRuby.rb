# This will be a game like Zork 1. Eventually.
# WIll this change synchronize?
class Scene
    def enter()
        puts "This scene is not yet configured. Subclass it and implement enter()."
        exit(1)
    end
end

class Engine
    
    def initialize(scene_map)
        @scene_map = scene_map
    end
    
    def play()
        current_scene = @scene_map.opening_scene()
        last_scene = @scene_map.next_scene('City')
        
        while current_scene != last_scene
            next_scene_name = current_scene.enter()
            current_scene = @scene_map.next_scene(next_scene_name)
        end
        
        current_scene.enter()
    end
end

class Inventory
    def initialize
        items = []
    end
    
    def add(item)
        @items.push(item)
    end
end

class Death < Scene
    def enter()
    end
end
class City < Scene
    def enter()
        first_word = ['go north', 'north', 'Go north', 'North', 'Go North', ]
        second_word = ['go south', 'south', 'Go south', 'South', 'Go South',]
        third_word = ['go east', 'east', 'Go east', 'South', 'Go South',]
        fourth_word = ['go west', 'west', 'Go west', 'West', 'Go West',]
        paper_choice = ['grab paper', 'read paper', 'take paper', 'pick up paper', 'paper', 'Paper', 'Grab Paper', 'Read', 'Read Paper',]
        
        puts "You are in the city square of the great Gokle Town,"
        puts "capital of the country of Wiertrik. To your north is a path "
        puts "that looks like it might lead out of the city. To your south is "
        puts "a path that leads deeper into the downtown denizens of the city."
        puts "To your west is a massive wall without a gate but with a paper pinned"
        puts "to the it. It is impossible to continue to your east, as market stalls "
        puts  "and buildings block your way. Which direction do you go?"
        
        answer = $stdin.gets.chomp
        
        if answer == 'first_word'
            return 'City_Outside'
        end
        
        if answer == 'second_word'
            return 'Deep_City'
        end
        
        if answer == 'third_word'
            puts "This direction is impassible. Try again please."
            return 'City'
        end
        
        if answer == 'fourth_word'
            return 'City'
        end
        if answer == 'paper_choice'
            puts "You pick up the paper and read it."
            puts "It says:"
            puts "HELLO AND WELCOME TO THE WORLD OF WEIRTRIK"
            puts "YOU SHOULD BE ABLE AT THE END OF THE GAME TO"
            puts "DEFEAT THE GREAT DRAGON KONBOG THAT IS THREATENING"
            puts "THE WHOLE LAND. GOOD LUCK!"
            return 'City'
        end
    end
end


class City_Outside < Scene
    def enter()
        
        puts "You walk along the path that leads out of the city."
        puts "At the gate of the city there is a weapons stall."
        retrons = 10 
        first_word = ['go north', 'north', 'Go north', 'North', 'Go North', ]
        second_word = ['go south', 'south', 'Go south', 'South', 'Go South',]
        third_word = ['go east', 'east', 'Go east', 'South', 'Go South',]
        fourth_word = ['go west', 'west', 'Go west', 'West', 'Go West',]
        fifth_word = ['buy', 'go to stall', 'buy weapons', 'purchase weapons', 'buy at stall', 'get weapons']
        
        choice = $stdin.gets.chomp 
        
        if choice == 'fifth_word'
            puts "You have #{retrons}."
            puts "A cheap elf sword costs 5 Retrons. (&5)"
            puts "A Viking axe costs &7."
            puts "A spear costs &10"
            puts "Do you want to buy something?"
            puts "If so, what?"
            buy_choice = $stdin.gets.chomp
            elf = ['sword', 'elf sword', 'Elf Sword', 'Elf sword', 'elf', 'cheap elf sword']
        end
        if buy_choice == 'elf'
            puts "Elf sword added to inventory. It is now usable."
            retrons -= 5
            puts "Which direction do you go now?"
            direction_choice = $stdin.gets.chomp
        end
        axe = ['Viking Axe', 'viking axe', 'axe', 'Axe']
        if buy_choice == 'axe'
            puts "Awesome Viking axe added to your inventory"
            retrons -= 7
            puts "Which direction do you go now?"
            direction_choice = $stdin.gets.chomp
        end
        spear = ['Spear', 'spear', 'buy spear']
        if buy_choice == 'spear'
            puts "The merchant looks at you strangely and says"
            puts "'And what do you want to be doing with a spear?"
            puts "I find that ridiculously sketchy.'"
            puts "He then gores you with the spear."
            return 'Death'
        end
        
        if  direction_choice == 'first_word'
            return 'Hovel'
        end
        
        if  direction_choice == 'second_word'
            return 'City'
        end
        if direction_choice == 'third_word'
            return 'Mountains'
        end
        if direction_choice == 'fourth_word'
            return 'Setting_Sun'
        end
    end
end

class Deep_City < Scene
    def enter()
        first_word = ['go north', 'north', 'Go north', 'North', 'Go North', ]
        second_word = ['go south', 'south', 'Go south', 'South', 'Go South',]
        third_word = ['go east', 'east', 'Go east', 'South', 'Go South',]
        fourth_word = ['go west', 'west', 'Go west', 'West', 'Go West',]
        kill_choice = ['kill', 'Kill', 'kill people', 'Kill People',]
        
        puts "You are deep inside the city. You jostle along"
        puts "through the crowds of people walking along the roadway"
        puts "You are in the middle of the roadway jammed with people."
        puts "Where do you go or what do you do?"
        
        choice2 = $stdin.gets.chomp
        
        if choice2 == 'first_word'
            return 'City'
        end
        if choice2 == 'second_word'
            return 'Downtown'
        end
        if choice2 == 'third_word'
            return 'City_Gate_East'
        end
        if choice2 == 'fourth_word'
            return 'City_Gate_West'
        end
        if choice2 == 'kill_choice'
            puts "With what weapon?"
            weapon_choice = $stdin.gets.chomp
            if weapon_choice == 'weapon'
                puts "You slaughter all the people, but the Army National Guard"
                puts "comes and kills you for your actions."
                return 'Death'
            elsif weapon_choice != 'weapon'
                puts "Either I do not understand that answer or"
                puts "you do not have access to the weapon. Please try again."
                return 'Deep_City'
            end
        end
    end
end


class Map
    @@scenes = {
        'City' => City.new(),    
        'City_Outside' => City_Outside.new(),
        'Death' => Death.new(),          
        'Deep_City' => Deep_City.new(),
    }
    
    
    def initialize(start_scene)
        @start_scene = start_scene
    end
    
    
    def next_scene(scene_name)
        val = @@scenes[scene_name]
        return val
    end
    
    def opening_scene()
        return next_scene(@start_scene)
    end
end

a_map = Map.new('City')
a_game = Engine.new(a_map)
a_game.play()