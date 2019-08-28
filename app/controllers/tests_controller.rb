require 'personality_traits'
require 'emotions'

class TestsController < ApplicationController
  def personality_traits
    lyrics = %{
Yeah, breakfast at Tiffany's and bottles of bubbles
Girls with tattoos who like getting in trouble
Lashes and diamonds, ATM machines
Buy myself all of my favorite things (Yeah)
Been through some bad shit
I should be a sad bitch
Who woulda thought it'd turn me to a savage?
Rather be tied up with calls and not strings
Write my own checks
Like I write what I sing, yeah (Yeah)
My wrist, stop watching, my neck is flossy
Make big deposits, my gloss is popping
You like my hair?
Gee, thanks, just bought it
I see it, I like it, I want it, I got it (Yeah)
I want it, I got it, I want it, I got it
I want it, I got it, I want it, I got it (Yeah)
You like my hair?
Gee, thanks, just bought it
I see it, I like it, I want it, I got it
(2 Chainz, yep)
My ideas are priceless
I know I'm the nicest
I knew you would like this
I must be psychic
I'm from the streets, baby
I'm nothing like them (Tru)
She's sweet in the day
but freaky when night come (Tell 'em)
It's mine, invested (Uh
I spend it on necklace (Uh)
I got the cash if I don't get credit (Uh)
And I'm well respected
So she feel protected
So scratch all the exes (Ex)
It's next like contestants (Woo)
It's blessings, no stressing, no flexing
Got one car parked right in the entrance
Got one car parked right at the exit
See, you didn't expect this
You think like a robot
I put bands in yo face like botox
I got it, I want it, I got it (Uh)
I want it, I got it (Uh),
I want it, I got it (Baby)
You like my hair?
Gee, thanks, just bought it (Oh yeah)
I see it, I like it, I want it, I got it (Yep)
Yeah, my receipts be looking like phone numbers
If it ain't money, then wrong number
Black card is my business card
The way it be setting the tone for me
I don't mean to brag
But I be like, put it in the bag, yeah
When you see them racks
They stacked up like my ass, yeah
Shoot, go from the store to the booth
Make it all back in one loop, gimme the loot
Never mind, I got a juice
Nothing but net when we shoot
Look at my neck
Look at my jet
Ain't got enough money to pay me respect
Ain't no budget when I'm on the set
If I like it, then that's what I get, yeah
I want it, I got it, I want it, I got it (Oh yeah)
I want it, I got it, I want it, I got it (Oh yeah, yeah)
You like my hair?
Gee, thanks, just bought it
I see it, I like it, I want it, I got it
(I see, yep)
}
    personality_traits = PersonalityTraits.new(lyrics)
    @percents = personality_traits.percents
    render :personality_test
  end

  def emotions
    lyrics_string = %{
      All the sisters of mercy, they are not departed or gone
They were waiting for me when I thought that I just can't go on
And they brought me their comfort and later they brought me this song
Oh, I hope you run into them, you who've been travelling so long
Yes, you who must leave everything that you cannot control
It begins with your family, but soon it comes around to your soul
Well, I've been where you're hanging, I think I can see how you're pinned
When you're not feeling holy, your loneliness says that you've sinned
Well, they lay down beside me, I made my confession to them
They touched both my eyes and I touched the dew on their hem
If your life is a leaf that the seasons tear off and condemn
They will bind you with love that is graceful and green as a stem
When I left they were sleeping, I hope you run into them soon
Don't turn on the lights, you can read their address by the moon
And you won't make me jealous if I hear that they sweetened your night
We weren't lovers like that and besides, it would still be all right
We weren't lovers like that and besides, it would still be all right
    }
    emotest = Emotions.new(lyrics_string)
    @joy = emotest.calc_joy
    @anger = emotest.calc_anger
    @fear = emotest.calc_fear
    @sadness = emotest.calc_sadness
    render :emotions_test
  end

  def lyrics_finder
    artist = 'nirvana'
    lyrics_finder = LyricsFinder.new(artist)
    @lyrics = lyrics_finder.lyrics
    render :lyrics_test
  end
end
