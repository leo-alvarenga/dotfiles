local quotes = {}

quotes.quotes = {
  { author = "Marcus Aurelius", text = "You have power over your mind — not outside events. Realize this, and you will find strength." },
  { author = "Seneca", text = "Luck is what happens when preparation meets opportunity." },
  { author = "Epictetus", text = "It’s not what happens to you, but how you react that matters." },
  { author = "Benjamin Franklin", text = "By failing to prepare, you are preparing to fail." },
  { author = "Niccolò Machiavelli", text = "Men in general judge more by appearances than by reality." },
  { author = "Sun Tzu", text = "Victorious warriors win first and then go to war." },
  { author = "Thomas Hobbes", text = "Covenants without the sword are but words." },
  { author = "Napoleon Bonaparte", text = "A leader is a dealer in hope." },
  { author = "Albert Einstein", text = "Strive not to be a success, but to be of value." },
  { author = "Warren Buffett", text = "The best investment you can make is in yourself." },
  { author = "Aristotle", text = "We are what we repeatedly do. Excellence then is a habit." },
  { author = "Marcus Aurelius", text = "Waste no more time arguing about what a good man should be. Be one." },
  { author = "Seneca", text = "Begin at once to live, and count each separate day as a separate life." },
  { author = "Bruce Lee", text = "Knowing is not enough; we must apply. Willing is not enough; we must do." },
  { author = "George S. Patton", text = "Accept the challenges so that you can feel the exhilaration of victory." },
  { author = "Sun Tzu", text = "Know your enemy and know yourself; victory is certain." },
  { author = "Niccolò Machiavelli", text = "It is necessary for a prince to know how to do wrong when required." },
  { author = "Thomas Hobbes", text = "Life without a common power is solitary, poor, nasty, brutish, and short." },
  { author = "Napoleon Bonaparte", text = "Impossible is a word to be found only in the dictionary of fools." },
  { author = "Abraham Lincoln", text = "Give me six hours to chop down a tree and I will spend the first four sharpening the axe." },
  { author = "Confucius", text = "Real knowledge is to know the extent of one’s ignorance." },
  { author = "Ralph Waldo Emerson", text = "Do the thing and you will have the power." },
  { author = "Helen Keller", text = "Alone we can do so little; together we can do so much." },
  { author = "Marcus Aurelius", text = "If it is not right, do not do it; if it is not true, do not say it." },
  { author = "Epictetus", text = "Make the best use of what is in your power, and take the rest as it happens." },
  { author = "Benjamin Franklin", text = "Well done is better than well said." },
  { author = "Niccolò Machiavelli", text = "Men are driven by two principal impulses: love and fear." },
  { author = "Sun Tzu", text = "Plan for what is difficult while it is easy." },
  { author = "Napoleon Bonaparte", text = "A leader is best when people barely know he exists." },
  { author = "Albert Einstein", text = "Life is like riding a bicycle. To keep balance, you must keep moving." },
  { author = "Marcus Aurelius", text = "Do every act of your life as if it were your last." },
  { author = "Seneca", text = "We suffer more often in imagination than in reality." },
  { author = "Confucius", text = "It does not matter how slowly you go as long as you do not stop." },
  { author = "Bruce Lee", text = "Adapt what is useful, reject what is useless, and add what is specifically your own." },
  { author = "Thomas Hobbes", text = "Words are wise men’s counters, but money for fools." },
  { author = "Sun Tzu", text = "He will win who knows when to fight and when not to fight." },
  { author = "Niccolò Machiavelli", text = "Everyone sees what you appear to be; few experience what you are." },
  { author = "Napoleon Bonaparte", text = "Courage isn’t having strength to go on — it’s going on when you don’t have strength." },
  { author = "Ralph Waldo Emerson", text = "What lies behind us and before us are small matters compared to what lies within us." },
  { author = "Abraham Lincoln", text = "Determine that the thing can and shall be done, and then we shall find the way." },
  { author = "Seneca", text = "Associate with people who will make a better man of you." },
  { author = "Epictetus", text = "Freedom is the only worthy goal in life. It is won by disregarding things beyond our control." },
  { author = "Niccolò Machiavelli", text = "Politics is the art of making possible what is necessary." },
  { author = "Sun Tzu", text = "Opportunities multiply as they are seized." },
  { author = "Marcus Aurelius", text = "Receive without pride, let go without attachment." },
  { author = "Benjamin Franklin", text = "Lost time is never found again." },
  { author = "Napoleon Bonaparte", text = "Do not fight too often with one enemy, or you will teach him all your art of war." },
  { author = "Thomas Hobbes", text = "Fear of things invisible is the natural seed of religion." },
  { author = "Confucius", text = "Before you embark on a journey of revenge, dig two graves." },
  { author = "Sun Tzu", text = "Strategy without tactics is the slowest route to victory." },
  { author = "Niccolò Machiavelli", text = "A wise ruler must know when to act without keeping faith." },
  { author = "George S. Patton", text = "Lead me, follow me, or get out of my way." },
}

function quotes.get_text(index)
	return quotes.quotes[index]
end

function quotes.get_random()
	local index = math.random(#quotes.quotes)
	local quote = quotes.get_text(index)

	return { quote.text, "", quote.author }
end

return quotes
