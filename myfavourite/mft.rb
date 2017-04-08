# My Favourite Things
# By Scinawa

use_bpm 100

my_sample = "/Users/scinawa/Desktop/Samples/"
drums_ab_sample = "Y:/SonicPi-songs/myfavourite/asdf.wav"
drums_c_sample = "Y:/SonicPi-songs/myfavourite/battuta_da_8.wav"
load_sample drums_ab
load_sample drums_c




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

chords_solo = ring (chord :e, :minor7), (chord :fs, :minor7)


# drums
bass_drums_ac = (ring true,false, false,false,  true,false, false, false,   true,false,false,false,   true,false, true,true)
bass_drums_b = (ring true,false, false,true,  false,false, false, true,   true,false,false,false,   true,false, true,true)



define :bass do |pattern|
  in_thread do
    with_fx :band_eq, freq: 50, res: 0.5, db: 3 do
      with_fx :krush, mix: 0.1, amp: 0.5 do
        with_fx :compressor, pre_amp: 1, threshold: 80  do
          with_fx :distortion, distort: 0.3 do
            in_thread do
              with_synth :supersaw  do
                with_fx :lpf, amp: 0.4, cutoff: 80, amp: 0.8 do
                  with_fx :normaliser, amp: 0.5 do
                    play_pattern_timed(pattern, 1.5)
                  end
                end
              end
            end
            in_thread do
              with_synth :subpulse do
                with_fx :normaliser, amp: 0.6 , hpf: 90, mix: 0.2, pre_amp: 0.1 do
                  for i in pattern
                    scala = i.permutation(3).to_a.sample
                    puts "Playing ", scala
                    play_pattern_timed(scala.map { |k| k - 12 }, 0.5)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end


define :metrodiocane do
  puts "uff"
  in_thread do
    (16*3).times do
      play :d4, amp: 0.3
      sleep 1.5
    end
  end
end


define :drums_ab do
  puts "ou"
  with_fx :rhpf do
    #    with_fx :normaliser, mix: 0.1 do
    sample drums_ab_sample, amp: 4.5, start: 0.0, finish: 0.490 , beat_stretch: (3*16)
  end
  #  end
end

define :drums_c do
  sample drums_c_sample, amp: 1, beat_stretch: 8
end


define :part_a do
  puts "Part A"
  drums_ab         # why se spoosto drums_ab sotto a bass... mi parte in ritardo!?
  metrodiocane
  bass(chords_a)
  
  sleep 16*1.5
  puts "o no"
end

define :part_b do
  metrodiocane
  puts "Part B"
  bass(chords_b)
  drums_ab
  sleep 16*1.5
end

define :part_c do
  puts "Part C"
  bass(chords_c)
  drums_c
  sleep 1.5*chords_c.length
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


##################

#### TODO ASSOLUTAMENTE

## registrati tutti gli accordi di chitarra e fa la figata di fare play dei sample con sonic pi




#set_sched_ahead_time! 0.5 #adjust as necessary.
with_fx :reverb,room: 0.1 do
  part_a #0:20 (la seconda volta con due voci)
  #part_a
  part_b
  part_c
  ##| part_c
  ##| part_brake
  ##| part_a
  ##| part_b
  ##| part_brake
  ##| part_c
  
  #part_ending # 5:19  x4 fading...
end


