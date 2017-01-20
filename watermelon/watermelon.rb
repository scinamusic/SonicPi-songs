# Welcome to Sonic Pi v2.11.1

use_bpm 60

amp_harmony1 = 1
amp_harmony2 = 1


amp_hi = 0.5
amp_kick = 1
amp_melody = 1.2
amp_pad = 0.7
amp_dsaw = 0.3


in_thread do
  use_synth :chipbass
  24.times do
    play_pattern_timed [:cs5, :a4, :e4, :gs3, :e3, :b3, :fs4, :b4, :ds5],
      [1,1,1,1,1,1,1,1,1],
      sustain: 0.5, release: 0.5, amp: amp_harmony1, pan:0.51
  end
end



in_thread do
  use_synth :dsaw
  24.times do
    play_pattern_timed [:cs4, :a3, :e3, :gs2, :e2, :b2, :fs3, :b3, :ds4],
      [1,1,1,1,1,1,1,1,1],
      sustain: 0.5, release: 0.5, amp: amp_harmony2, pan:-0.51
  end
end

#in_thread do
#  use_synth :saw
#  24.times do
#    play_pattern_timed [:cs4, :a3, :e3, :gs2, :e2, :b2, :fs3, :b3, :ds4],
#      [1,1,1,1,1,1,1,1,1],
#      sustain: 0.5, release: 0.5, amp: amp_bass, pan:0.51
#  end
#end

live_loop :kick do
  24.times do
    if (spread 1,9).tick then
      sample :drum_splash_soft, amp: 1, cutoff: 120
    end
    sleep 0.1
    
  end
end

in_thread do
  24.times do
    with_fx :slicer, mix: 0.7, phase: 0.25, pulse_width: 0.1 do
      with_fx :hpf, cutoff: 130 do
        with_synth :noise do
          play :d1, decay: 1, amp: 1.5
        end
      end
    end
    sleep 1
  end
end



#live_loop :hats do
#  sync :kick
#  if (spread 3, 9).tick then
#    with_synth :pnoise do
#      play :d1, attack: 0.05, decay: 0.08, release: 0.1
#    end
#  end
#end


#define :part1 do


