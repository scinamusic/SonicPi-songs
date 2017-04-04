# My Favourite Things
# By Scinawa

use_bpm 64

my_sample = "/Users/scinawa/Desktop/Samples/"
solenoid = "/Users/scinawa/Desktop/Samples/solenoid"

st = sedicesimo_terzina = 0.1666
s = sedicesimo = 0.25


ot = ottavo_terzina = 0.333
o = ottavo = 0.5
op =  ottavo_puntato = 0.75

q = quarto = 1
qp =  quarto_puntato = 1.5

m = minima = 2
mp = minima_puntata = 3

sb = semibreve = 4
# breve 2
# breve_puntato = 3


#Megamixer
bass=1
harmony=1
drums=1


# f#-7b5 = 0,3,6,10 = m7-5
# ricordati che gli accordi di settima sono di settima DI DOMINANTE: aka dom7!!

# ma quindi con 7-9 si intende già che è un accordo di dominante? non è major7 e non è nemmeno un accordo di settima minore.
# in questo modo appena vedo un accordo di questo tipo, so già la tonica del brano! right or not?

# hPart A
chords_a = ring   (chord :e, :minor7),   (chord :fs, :minor7), (chord :e, :minor7),   (chord :fs, :minor7),
  (chord :c, :major7), (chord :c, :major7), (chord :c, :major7), (chord :c, :major7),
  (chord :a, :minor7), (chord :d, :dom7), (chord :g, :major7), (chord :c, :major7),
  (chord :g, :major7), (chord :c, :major7), (chord :fs, :'m7-5'), (chord :b, :dom7)

# part B
chords_b = ring   (chord :e, :major7),   (chord :fs, :minor7), (chord :e, :major7),   (chord :fs, :minor7),
  (chord :a, :major7), (chord :a, :major7), (chord :a, :major7), (chord :a, :major7),
  (chord :a, :minor7), (chord :d, :dom7), (chord :g, :major7), (chord :c, :major7), (chord :g, :major7), (chord :c, :major7),
  (chord :fs, :'m7-5'), (chord :b, :'7-9')

# part C
chords_c = ring   (chord :e, :minor7),   (chord :e, :minor7), (chord :fs, :'m7-5'),   (chord :b, :dom7),
  (chord :e, :minor7), (chord :e, :minor7), (chord :c, :major7), (chord :c, :major7)

chords_d = ring (chord :c, :major7), (chord :c, :major7) , (chord :a, :dom7), (chord :c, :dom7),
  (chord :g, :major7), (chord :c, :major7), (chord :c, :major7), (chord :d, :dom7)

chords_ending = ring (chord :g, '6'), (chord :c, :major7), (chord :g, '6'), (chord :c, :major7),
  (chord :g, :major7), (chord :c, :major7), (chord :fs, :'m7-5'), (chord :fs, :dom7)


# drums
bass_drums_ac = (ring true,false, false,false,  true,false, false, false,   true,false,false,false,   true,false, true,true)
bass_drums_b = (ring true,false, false,true,  false,false, false, true,   true,false,false,false,   true,false, true,true)




define :bass do |pattern|
  in_thread do
    with_fx :band_eq, freq: 50, res: 0.5, db: 3 do
      with_fx :krush, mix: 0.2, amp: 0.5 do
        with_fx :compressor, pre_amp: 1, threshold: 80  do
          with_fx :distortion, distort: 0.8 do
            in_thread do
              with_synth :dsaw do
                with_fx :lpf, cutoff: 80 do
                  play_pattern_timed(pattern, 1)
                end
              end
            end
            ##| in_thread do
            ##|   with_synth :dpulse do
            ##|     with_fx :lpf, cutoff: 80, mix: 1, pre_amp: 1 do
            ##|       playarray(notearray, durationarray, 0, 0.9, 0.1)
            ##|     end
            ##|   end
            ##| end
          end
        end
      end
    end
  end
end


define :drums_ac do
  in_thread do
    32.times do
      sample my_sample, "Closed-Hi-Hat-2", amp: 0.85, hpf: 100 if (spread, 18, 18).tick
      with_fx :reverb, amp: 1, room: 1 do
        sample my_sample, "Korg-M3R-Side-Stick", amp: 2 if (spread, 4, 16).look
      end
      sleep 0.5
    end
  end
  
  in_thread do
    32.times do
      tick
      with_fx :compressor do
        sample :drum_heavy_kick, amp: 2 if bass_drums_ac.look
      end
      sleep 0.5
    end
  end
  
end


define :drums_b do
  in_thread do
    tick
    tick
    16.times do
      with_fx :compressor do
        sample my_sample, "Closed-Hi-Hat-2", amp: 0.85, hpf: 100 if (spread, 18, 18).tick
      end
      with_fx :reverb, amp: 1, room: 1 do
        sample my_sample, "Korg-M3R-Side-Stick", amp: 2 if (spread, 5, 16).look
      end
      sleep 0.5
    end
  end
  
  in_thread do
    16.times do
      with_fx :compressor do
        sample :drum_heavy_kick, amp: 2 if bass_drums_b.tick
      end
      sleep 0.5
    end
  end
  
end


define :part_a do
  puts "Part A"
  bass(chords_a)
  drums_ac
  sleep 4*16
end

define :part_b do
  puts "Part B"
  2.times do
    trumpet(trumpet_b_line,trumpet_b_time)
    bass(bass_b_line,bass_b_time)
    harmony(chords_b)
    drums_b
    sleep 8
  end
end

define :part_c do
  puts "Part C"
  2.times do
    trumpet(trumpet_c_line,trumpet_c_time)
    bass(bass_c_line,bass_c_time)
    harmony(chords_c)
    drums_ac
    sleep 8
  end
end

define :brake_one do
  puts "Break one"
  4.times do
    bass(bass_b_line,bass_b_time)
    harmony(chords_b)
    drums_b
    sleep 4*2
  end
end

define :solo do
  puts "Start solo!"
  counter=8
  8.times do
    bass(bass_a_line,bass_a_time)
    harmony(chords_a)
    drums_b
    sleep 4*2
    puts "round: ", counter
    counter=counter-1
  end
end

define :part_ending do
  puts "Bye bye"
  # very important construct, it allows to specify a control for the effect!!!
  with_fx :echo, mix: 0 do |echoc|
    with_fx :level do |vol|
      control vol, amp: 1
      in_thread do
        4.times do
          trumpet(trumpet_b_line,trumpet_b_time)
          bass(bass_b_line,bass_b_time)
          harmony(chords_b)
          drums_b
          sleep 8
        end
      end
      sleep 24
      control echoc, mix: 1, mix_slide: 3, decay: 2, phase: 0.5
      control vol,  amp: 0, amp_slide: 5
    end
  end
end




#procedure to play an array of notes and associated array of durations
#shift allows for transposing, vol for volume and voice for synth used
define :playarray do |notearray,durationarray,shift=0,vol=1,sust=0.4|
  # Thanks to Robin Newman: @rbnpi (Github..)
  notearray.zip(durationarray).each do |notearray,durationarray| #traverse both arrays together
    if notearray == :r #if rest just wait duration
      sleep durationarray
    else
      with_transpose shift do #allows transposition (may be 0) for the part
        play notearray, sustain: sust, amp: vol, sustain: durationarray * 0.99,      release: durationarray * 0.1 #play note
        sleep durationarray #gap till next note
      end
    end
  end
end




#set_sched_ahead_time! 0.5 #adjust as necessary.
with_fx :reverb,room: 0.8 do
  
  part_a #0:20 (la seconda volta con due voci)
  ##| part_b
  ##| part_c
  ##| part_brake
  ##| part_a
  ##| part_b
  ##| part_brake
  ##| part_c
  
  
  part_ending # 5:19  x4 fading...
  
end



