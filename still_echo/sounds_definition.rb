### SOUNDS PART

define :a_trumpet do
  1.times do
    in_thread do
      with_fx :reverb do
        with_synth :dsaw do
          2.times do
            playarray(trumpet_a_line, trumpet_a_time,0,1)
          end
        end
      end
    end
  end
end


define :a_bass do
  1.times do
    in_thread do
      with_fx :reverb do
        with_synth :blade do
          2.times do
            playarray(bass_a_line, bass_a_line,0,3)
          end
        end
      end
    end
  end
end


define :a_drums do
  1.times do
    in_thread do
      with_fx :reverb do
        with_synth :blade do
          2.times do
            playarray(drums_a_line, drums_a_line,0,1)
          end
        end
      end
    end
  end
end