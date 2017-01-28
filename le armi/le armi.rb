use_bpm 75

s = sedicesimo = 0.25
o = ottavo = 0.5
q = quarto = 1


live_loop :charlie do
  with_fx :normaliser, level: 0.4 do
    with_fx :hpf, cutoff: 110 do
      with_synth :noise do
        #play 120, attack: 0.005, decay: 0.005, sustain: 0.07, release: 0.01
        sample :drum_cymbal_closed, amp: 1, finish: 0.5, hpf: rrand(60,130)
        sleep o
      end
    end
  end
end

live_loop :cazza do
  sync :charlie
  with_fx :reverb, room: 0.5  do
    with_fx :distortion, distort: 0.96, amp: 0.8, pre_amp: 1, mix: 1 do
      if [false, false, false, false, false, false, true, true].ring.tick
        sample :drum_heavy_kick, amp: 1
      end
      sleep 0.5
    end
  end
end



##| live_loop :sdrummi do
##|   sync :charlie
##|   with_fx :band_eq do

##|   end
##| end


live_loop :cmaj7 do
  sync :charlie
  
  sus = rrand(0.1, 0.4)
  puts "Sus:", sus
  
  with_fx :bitcrusher do |c_sample|
    control c_sample, cutoff: rrand(80,129), sample_rate: rrand(1000, 10000)
    with_fx :wobble, cutoff_max: rrand(90,129), probability: rrand(0,1), phase: rrand(0,1)  do
      with_fx :reverb, room: 0.9, damp: 0.9 do #reverb is better inside whobble and bitcrusher! why?
        notes = [:c3, :c2, :r, :b1, :b1, :b1, :r, :c2, :r]
        temps = [ s,   s,   s,   s,  s,   s,  s,   s,  q]
        
        in_thread do
          with_synth :dsaw do
            c_dsaw = play_pattern_timed notes, temps, sustain: sus, release: 0.15, pan: 0.2
          end
        end
        in_thread do
        end
        
        in_thread do
          with_synth :fm do
            c_fm = play_pattern_timed notes, temps, sustain: sus, release: 0.15, pan: -0.2, amp: 0.1
          end
        end
        in_thread do
          with_synth :sine do
            c_sine = play_pattern_timed notes, temps, sustain: sus, release: 0.15, pan: -0.2
          end
        end
        sleep 4
      end
    end
  end
end

