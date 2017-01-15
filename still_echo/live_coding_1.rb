live_loop :gigi do
  sync :asdf
  with_fx :echo do
    
    with_synth :beep do
      with_fx :bitcrusher, bits:15000, amp: 0.3 do
        play 80, amp: 3
        sleep 2
      end
      
      with_fx :distortion, distort: 0.99, amp: 0.2 do
        with_fx :lpf, cutoff: 60 do
          play 40
          sleep 0.5
        end
      end
    end
  end
end


live_loop :bassline do
  sync :asdf
  with_fx :compressor do
    with_synth :dsaw do
      play_pattern_timed [:f2,:f2,:f2,:e2,:e2,:e2,:e2],[0.25,0.25,0.25,1,1,0.5,0.5,0.6,0.6], amp: 1
      sleep 8
    end
  end
end




live_loop :asdf do
  with_fx :bitcrusher do
    sample :ambi_drone
  end
  sleep 3
end

live_loop :asdf2 do
  sync :asdf
  with_fx :bitcrusher do
    sample :loop_amen, beat_stretch: 3, amp: 3
  end
end





