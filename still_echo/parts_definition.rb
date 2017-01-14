# DEFINITION OF EACH PART

define :intro do
  1.times do
    in_thread do
      a_trumpet
    end
  end
end




define :part_a do
  1.times do
    in_thread do
      a_trumpet
    end
    in_thread do
      a_bass
    end
    in_thread do
      a_drums
    end
  end
end

define :part_b do
  1.times do
    in_thread do
      b_trumpet
    end
    in_thread do
      b_bass
    end
    in_thread do
      b_drums
    end
  end
end



# THE FUCKING SONG!!!