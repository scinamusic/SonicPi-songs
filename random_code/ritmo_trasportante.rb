
live_loop :metronome do
  sample :drum_bass_hard, amp:1
  sleep 2
end


live_loop :kick do
  if (spread 1,4).tick then
    sample :bd_tek, amp: 1, cutoff: 110
  end
  sleep 0.25
end


live_loop :hats do
  sync :kick
  if (spread 3, 8).tick then
    with_synth :pnoise do
      play :d1, attack: 0.05, decay: 0.08, release: 0.1
    end
  end
end

