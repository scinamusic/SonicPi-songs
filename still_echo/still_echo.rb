use_bpm 65


# la canzone è divisa into:
# - definizione spartito
# - definizione suoni
# - definizione di ogni singola parte di brano, dove si compongono gli strumenti assieme) definiamo A , b c
# - devinizione brano: combihiamo tutte le parti assieme come il brano richiede.. (ABABCCCDA.. etc)


# In questo modo si rispecchia le descrizione della "canzone" come lo farebbe un umano:
# inizia a descrivere prima la struttura della canzone in termini di ripetizioni di varie figure principali.
# poi inizi a descrivere ciascuna di queste "figure principali", quali strumenti ci sono, e cosa fanno:
# poi descrivi le varie linee melodiche e armoniche degli strumenti
# fino a descrivere il loro suono nel dettaglio


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


# DEFINITION OF EACH PART

#trumpet
trumpet_a_line = [:eb4, :d4, :c4, :r,  :eb4,  :d4, :c4, :r,     :g3, :ab3, :eb4, :eb4, :r, :r, :r ]
trumpet_a_time = [o,     s,   s,  q,    o,     s,   s,  op,      s,   o,   s,    s,     q,  q, q]

trumpet_b_line = [:c5,:c5,:ab4,:g4,:eb4,:d4,:eb4, :g4, :ab4,]
trumpet_b_time = [qp,  st, st, st,  q,   ot, ot,  ot, sb ]


trumpet_c_line = [:eb4,:d4,:c4,:eb4,:d4,:c4,:r]
trumpet_c_time = [m,m,m,m,m,m,m,m,m,m,m,m,m,m,]


#bass
bass_a_line= [:c2, :g1, :bb1, :c2, :c2,  :r, :c2,:c2, :ab1, :c2, :ab1, :ab1,  :ab1, :ab1, :ab1]
bass_a_time = [q,   s,   s,    s,  s,    q,    s,  s,  s,    s,   q,   s,    s,   s,    s ]



bass_b_line= [:c2, :g1, :bb1, :c2, :c2,  :r, :r,:c2, :g1, :bb1, :c2, :c2,  :r, :r]
bass_b_time = [q,   s,   s,    s,  s,    q,  q,q,   s,   s,    s,  s,    q,  q]

bass_c_line = [:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4,:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4]
bass_c_time = [m,m,m,m,m,m,m,m,m,m]


#drums
drums_a_line = [:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4,:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4]
drums_a_time = [m,m,m,m,m,m,m,m,m,m]

drums_b_line = [:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4,:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4]
drums_b_time = [m,m,m,m,m,m,m,m,m,m]

drums_b_line = [:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4,:eb4,:d4,:c4,:eb4,:d4,:c4,:r,:g3,:ab3,:eb4]
drums_b_time = [m,m,m,m,m,m,m,m,m,m]



# STRUMENTI
define :trumpet do |notearray,durationarray,shift=0,vol=1|
  in_thread do
    with_fx :reverb do
      with_synth :chiplead do
        playarray(notearray, durationarray,0,1)
      end
    end
  end
end


define :bass do |notearray,durationarray,shift=0,vol=1|
  in_thread do
    with_fx :reverb do
      with_fx :compressor do
        with_synth :dsaw do
          playarray(notearray, durationarray,0,2,0.2)
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
  in_thread do
    2.times do
      in_thread do
        trumpet(trumpet_a_line,trumpet_a_time)
      end
      in_thread do
        bass(bass_a_line,bass_a_time)
      end
      #in_thread do
      #  drums(drums_a_line,drums_a_time)
    end
  end
  sleep 4*2  #end
end



define :part_b do
  in_thread do
    4.times do
      in_thread do
        trumpet(trumpet_b_line,trumpet_b_time)
      end
      in_thread do
        bass(bass_b_line,bass_b_time)
      end
    end
  end
  sleep 4*2
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
with_fx :reverb,room: 0.6 do
  intro
  part_b
  
  part_a
  #part_c
  #part_a
  #part_c
  
  #brake
  
  #part_a
  #part_c
  #part_a
  #part_c
  
  
end