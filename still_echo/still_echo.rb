# Still Echo
# Mute beat

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
trumpet=1
bass=1
harmony=1
drums=1



# DEFINITION OF EACH PART

#trumpet
trumpet_a_line = [:eb4, :d4, :c4, :r,  :eb4,  :d4, :c4, :r,     :g3, :ab3, :eb4, :eb4, :r, :r, :r ]
trumpet_a_time = [o,     s,   s,  q,    o,     s,   s,  op,      s,   o,   s,    s,     q,  q, q]

trumpet_b_line = [:c5,:c5,:ab4,:g4,:eb4,:d4,:eb4, :f4, :g4,]
trumpet_b_time = [qp,  st, st, st,  q,   ot, ot,  ot, mp ]


trumpet_c_line = [:g4, :f4,    :eb4, :r,  :g4, :r,  :f4, :r,  :d4, :r, :eb4, :c4, :r, :r, :r]
trumpet_c_time = [q,    q,      s,   s,    s,   s,   s,   s,   s,   s, o, o, o, o, q]


#bass
bass_a_line= [:c2, :g1, :bb1, :c2, :c2,     :r,    :c2, :c2, :bb1, :c2,  :ab1,  :ab1, :ab1, :ab1, :ab1,   :r, :ab1]
bass_a_time = [q,   s,   s,    s,  s,        q,      s,  s,    s,   s,     q,    s,     s,   s,  s,        q,  q ]


bass_b_line= [:c2, :g1, :bb1, :c2, :c2,  :r, :r, :c2, :g1, :bb1, :c2, :c2,  :r, :r]
bass_b_time = [q,   s,   s,    s,  s,    q,  q,   q,   s,   s,    s,  s,    q,  q]

bass_c_line = [:c2,  :c2, :c2, :c2,  :c2,  :r,  :c2,   :c2,  :g1,  :bb1, :c2, :r,  :c2]
bass_c_time = [q,      s,   s,   s,   s,    o,   qp,    q,     s,   s,    s,  s,   qp]


# harmony
chords_a = ring   (chord :c, :minor7),   (chord :c, :minor7), (chord :c, :minor7),   (chord :c, :minor7),
  (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7)

chords_b = ring  (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7),
  (chord :c, :minor),   (chord :c, :minor), (chord :c, :minor),   (chord :c, :minor)

chords_c = ring   (chord :c, :minor7),   (chord :c, :minor7), (chord :c, :minor7),   (chord :c, :minor7),
  (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7)



# drums
bass_drums_ac = (ring true,false, false,false,  true,false, false, false,   true,false,false,false,   true,false, true,true)
bass_drums_b = (ring true,false, false,true,  false,false, false, true,   true,false,false,false,   true,false, true,true)



define :harmony do |notearray,shift=0,vol=1|
  in_thread do
    8.times do
      sleep o
      play_chord chords_b.tick, amp: 2
      sleep o
    end
  end
end


# STRUMENTI
define :trumpet do |notearray,durationarray,shift=0,vol=1|
  in_thread do
    with_fx :reverb do
      with_fx :flanger, delay: 0.01 do
        with_fx :distortion, distort: 0.5 do
          with_fx :lpf, cutoff: 120 do
            with_fx :gverb, damp: 1 do
              in_thread do
                with_synth :dsaw do
                  playarray(notearray, durationarray,0,vol=0.04,sust=0.3)
                end
              end
              in_thread do
                with_synth :dpulse do
                  playarray(notearray, durationarray,0,vol=0.04,sust=0.3)
                end
              end
            end
          end
        end
      end
    end
  end
end



define :bass do |notearray,durationarray,shift=0,vol=1|
  in_thread do
    with_fx :band_eq, freq: 50, res: 0.5, db: 3 do
      with_fx :krush, mix: 0.2, amp: 0.5 do
        with_fx :compressor, pre_amp: 1, threshold: 80  do
          with_fx :distortion, distort: 0.8 do
            in_thread do
              with_synth :d
              saw do
                with_fx :lpf, cutoff: 80 do
                  playarray(notearray, durationarray,0,0.9,0.1)
                end
              end
            end
            in_thread do
              with_synth :dpulse do
                with_fx :lpf, cutoff: 80, mix: 1, pre_amp: 1 do
                  playarray(notearray, durationarray, 0, 0.9, 0.1)
                end
              end
            end
          end
        end
      end
    end
  end
end


define :drums_ac do
  in_thread do
    tick
    tick
    16.times do
      sample my_sample, "Closed-Hi-Hat-2", amp: 0.85, hpf: 100 if (spread, 18, 18).tick
      with_fx :reverb, amp: 1, room: 1 do
        sample my_sample, "Korg-M3R-Side-Stick", amp: 2 if (spread, 4, 16).look
      end
      sleep 0.5
    end
  end
  
  in_thread do
    16.times do
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


# STRUTTURA
define :intro do
  puts "Intro"
  1.times do
    trumpet(trumpet_a_line,trumpet_a_time)
    sleep 4*2
  end
end


define :part_a do
  puts "Part A"
  2.times do
    #in_thread do
    trumpet(trumpet_a_line,trumpet_a_time)
    #end
    #in_thread do
    bass(bass_a_line,bass_a_time)
    harmony(chords_a)
    drums_ac
    sleep 8
  end
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
  
  with_fx :echo, decay: 3, pre_amp: 0.8, max_phase: 0.4, phase: 0.25, max_phase: 0.55 do
    intro #0:00
  end
  
  part_b #0:20 (la seconda volta con due voci)
  part_b
  
  part_a  # 0:51 (tutte e due le voci, una un ottava piu in basso)
  part_c # 1:36 (tutte e due le voci, una un ottava piu in basso)
  
  part_a
  part_c
  
  brake_one # 1:52
  
  part_a # 2:07
  part_c #
  
  part_b # 2:38
  
  brake_one # 2:50   x2 alone bass
  solo       # x8 solo
  
  part_a # 4:18  (cambia un pelo il basso)
  part_c # 4:33
  part_a # 4:49 (cambia il basso) con la terzinatura all'inizio dei primi crochet
  part_c # 5:04
  
  
  part_ending # 5:19  x4 fading...
  
end



