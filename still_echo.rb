use_bpm 60


##| Drumkit
define :A_trumpet do
  with_fx :reverb do
    with_synth :blade do
      2.times do
        
        
        
      end
    end
  end
end



##| Bass




##| Trumpets
define :A_trumpet do
  with_fx :reverb do
    with_synth :blade do
      2.times do
        
        
        
      end
    end
  end
end


define :A_trumpet do
  with_fx :reverb do
    with_synth :blade do
      2.times do
        
        
        
      end
    end
  end
end






##| Structure

define :A do
  with_fx :reverb do
    2.times do
      A_trumpet
      A_bass
      A_drums
      A_guitar
      A_piano
    end
  end
end
end

define :B do
  with_fx :reverb do
    2.times do
      B_trumpet
      B_bass
      B_drums
      B_guitar
      B_piano
    end
  end
end
end

define :C do
  with_fx :reverb do
    2.times do
      C_trumpet
      C_bass
      C_drums
      C_guitar
      C_piano
    end
  end
end
end


define :brake_1 do
  4.times do
    BASS
    brake_drums
  end
end

define :brake_2 do
  4.times do
    
  end
  8.times do
    
  end
end




in_thread(name: :ontop) do
  with_fx :reverb do
    1.times do    # A x 2
      A
    end
    1.times do    # B x 4
      B
    end
    
    2.times do    # A x 2  C x 2  -   A x 2 C x 2
      A
      C
    end
    
    1.times do
      brake_1    # 4 bars of bass
    end
    
    1.times do   # A x 2  C x 2
      A
      C
    end
    
    2.times do   # B x 2
      B
    end
    
    8.times do
      brake_2   # 8 bars di bass
    end
    
    2.times do    # A x 2  C x 2  -   A x 2 C x 2
      A
      C
    end
    
    1.times do    # B x 4
      B
    end
    
  end
  
  
  
  
  