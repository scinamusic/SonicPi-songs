use_bpm 65


v = :tri #tune
bv = :saw #bass part


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
trumpet_b_time = [qp,  st, st, st,  q,   ot, ot,  ot, sb ]


trumpet_c_line = [:g4, :f4,  :eb4, :g4,  :f4,  :d4, :eb4, :c4, :r, :r, :r]
trumpet_c_time = [q,    q,   o,   o,     o,   o,    o, o, o, o, q]


#bass
bass_a_line= [:c2, :g1, :bb1, :c2, :c2,  :r, :c2,:c2, :bb1, :c2, :ab1, :ab1,  :ab1, :ab1, :ab1]
bass_a_time = [q,   s,   s,    s,  s,    q,    s,  s,  s,    s,   q,   s,    s,   s,    s ]



bass_b_line= [:c2, :g1, :bb1, :c2, :c2,  :r, :r, :c2, :g1, :bb1, :c2, :c2,  :r, :r]
bass_b_time = [q,   s,   s,    s,  s,    q,  q,   q,   s,   s,    s,  s,    q,  q]

bass_c_line = [:ab1,  :ab1, :ab1, :ab1,:ab1, :r,  :ab1,   :c2, :g1, :bb1, :c2,  :r, :c2]
bass_c_time = [q,      s,   s,     s,   s,    o,   q,     q,   s,   s,    o,   s,    q]


#drums
drums_a_line = [:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4,:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4]
drums_a_time = [m,m,m,m,m,m,m,m,m,m]

drums_b_line = [:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4,:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4]
drums_b_time = [m,m,m,m,m,m,m,m,m,m]

drums_b_line = [:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4,:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4]
drums_b_time = [m,m,m,m,m,m,m,m,m,m]

chords_a = ring   (chord :c, :minor7),   (chord :c, :minor7), (chord :c, :minor7),   (chord :c, :minor7),
  (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7)


chords_b = ring  (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7),
  (chord :c, :minor),   (chord :c, :minor), (chord :c, :minor),   (chord :c, :minor)

chords_c = ring   (chord :c, :minor7),   (chord :c, :minor7), (chord :c, :minor7),   (chord :c, :minor7),
  (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7), (chord :ab, :major7)


#play_chord [:e2,:e3,:b3],sustain: (b * 0.9),release: (b * 0.1),amp: 0.4


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
      with_fx :lpf, cutoff: 110 do
        with_synth :dsaw do
          playarray(notearray, durationarray,0,vol=1,sust=0.3)
        end
      end
    end
  end
end



define :bass do |notearray,durationarray,shift=0,vol=1|
  in_thread do
    with_fx :krush, mix: 0.2, amp: 0.5 do
      with_fx :compressor, pre_amp: 3, threshold: 70  do
        with_fx :reverb, room: 0.2 do
          with_synth :dsaw do
            playarray(notearray, durationarray,0,1.5,0.2)
          end
        end
      end
    end
  end
end


define :drums do |notearray,durationarray,shift=0,vol=1|
  1.times do
    in_thread do
      with_fx :reverb do
        with_synth :blade do
          2.times do
            playarray(notearray, durationarray,0,1)
          end
        end
      end
    end
  end
end

# STRUTTURA

define :intro do
  1.times do
    trumpet(trumpet_a_line,trumpet_a_time)
    sleep 4*2
  end
end




define :part_a do
  2.times do
    #in_thread do
    trumpet(trumpet_a_line,trumpet_a_time)
    #end
    #in_thread do
    bass(bass_a_line,bass_a_time)
    harmony(chords_a)
    sleep 8
  end
  
  #in_thread do
  #
  #end
  #sleep 4*2  #end
end



define :part_b do
  
  4.times do
    trumpet(trumpet_b_line,trumpet_b_time)
    bass(bass_b_line,bass_b_time)
    harmony(chords_b)
    sleep 8
  end
end

define :part_c do
  4.times do
    trumpet(trumpet_c_line,trumpet_c_time)
    bass(bass_c_line,bass_c_time)
    harmony(chords_c)
    sleep 4*2
  end
end


define :brake_one do
  4.times do
    bass(bass_b_line,bass_b_time)
    sleep 4*2
  end
end



live_loop :click do
  sample :drum_cymbal_pedal
  sleep 1
end



#procedure to play an array of notes and associated array of durations
#shift allows for transposing, vol for volume and voice for synth used
define :playarray do |notearray,durationarray,shift=0,vol=1,sust=0.4|
  notearray.zip(durationarray).each do |notearray,durationarray| #traverse both arrays together
    if notearray == :r #if rest just wait duration
      sleep durationarray
    else
      with_transpose shift do #allows transposition (may be 0) for the part
        play notearray, sustain: sust #eamp: vol,sustain: durationarray * 0.99,release: durationarray * 0.1 #play note
        sleep durationarray #gap till next note
      end
    end
  end
end







#set_sched_ahead_time! 0.5 #adjust as necessary.
with_fx :reverb,room: 0.5 do
  
  with_fx :echo, decay: 2, phase: 0.35, max_phase: 0.55 do
    intro #0:00
  end
  
  part_b #0:20
  
  part_a  # 0:51
  part_c # 1:36
  
  part_a
  part_c
  
  brake_one # 1:52
  
  part_a # 2:07
  part_c #
  
  part_b # 2 TIMES NOT FOUR! 2:38
  
  breake_two # 2:50   x2 alone bass
  breake_two       # x8 solo
  
  part_a # 4:18
  part_c # 4:33
  part_a
  part_c
  part_b # 5:19  x4 fading...
  
end
