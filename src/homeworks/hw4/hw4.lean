/-
CS 2120 F22 Homework #4. Due Oct 13.
-/

/- #1A [10 points]

Write a formal proposition stating that 
logical and (∧) is associative. That is, 
for arbitrary propositions, P, Q, and R,
P ∧ (Q ∧ R) is true *iff* (P ∧ Q) ∧ R is, 
too. Replace the placeholder (_) with your
answer.
-/

def and_associative : Prop := ∀ (P Q R), P ∧ Q ∧ R ↔ (P ∧ Q) ∧ R

-- and is right associative




/- #1B [10 points]

Give an English language proof. Identify
the inference rules of predicate logic
that you use in your reasoning.
-/

/-
Answer: 
-/

/- #1C [5 points]

Give a formal proof of the proposition.
Hint: unfold and_associative to start.
-/

theorem and_assoc_true : and_associative :=
begin
unfold and_associative,     -- expand definition of and_associative
assume P Q R,               -- ∀ intro
apply iff.intro _ _,        -- iff intro 

-- forward
assume pqr,                 -- assume premise 
cases pqr with p qr,        -- "unbox" proofs of P and of Q ∧ R
cases qr with q r,          -- "unbox" proofs of Q and R
let pq := (and.intro p q),  -- "rebox" proofs of P and of Q to prove P ∧ Q
apply (and.intro pq r),     -- "box" that up with a proof of r
-- that complete the proof in the forward direction

-- reverse 


end



/- #2A [10 points]

Write the proposition that ∨ is associative.,
analogous to the proposition about ∧ in #1.
-/

def or_associative : Prop := 
  _


/- #2B [10 points]

Write an English language proof of it, citing
the specific inference rules you use in your
reasoning.
-/


/- #2C [5 points]

Complete the following formal proof.
-/

theorem or_associative_true : or_associative :=
begin
end


/- #3A [10 points]
Write a formal statement of the proposition.
-/

def arrow_transitive : Prop :=
  _


/-
If there smoke there's fire
If there's fire there's light
If there's light, everything's good
And there's smoke. So everything's good.
Right?
-/

-- The basic propositions
variables (Smoke Fire Light Good : Prop)
-- The implications
variables (sf : Smoke → Fire) (fl : Fire → Light) (lg : Light → Good)
-- The premise
variable (s : Smoke)

example : ∀ (S F L G : Prop), (S → F) → (F → L) → (L → G) → S → G:=
begin
assume S F L G,   -- assume the basic propositions
assume sf fl lg,  -- assume the implication hypotheses
assume s,         -- assume there's smoke, now show everything good

/- this works
apply lg,
apply fl,
apply sf,
exact s
-/

-- so does this
exact lg (fl (sf s)),
-- make sure you understand it both ways
-- understand arrow elimination
-- arrow elimination is like function application!
end


/-
Eercise with negation
-/

example :0 ≠ 1 :=
begin
assume p,
cases p,
end 


example : ∀ P, ¬(P ∧ ¬P) :=
begin
assume P,
assume pandnp,
cases pandnp with p np,
apply false.elim (np p),
end

/- #3B [10 points]

Write an English language proof of the proposition
that for any propositions, X, Y, and X, it's the
case that (X → Y) → (Y → Z) → (X → Z). In other
words, implication is "transitive." Hint: Recall
that if you have a proof of, say, X → Y, and you 
have a proof of X, you can derive a proof of Y by
arrow elimination. Think of it as applying a proof
of an implication to a proof of its premise to get
yourself a proof of its conclusion.
-/


/- #3C [5 points]. 
Write a formal proof of it.
-/


/- #4
Suppose that if it's raining then the streets
are wet. This problem requires you to prove that
if the streets are not wet then it's not raining.
-/

/- #4A [10 points]

Start by writing the proposition in predicate
logic by completing the following answer.
-/

def contrapositive : Prop :=
  ∀ (Raining Wet : Prop), 
    (Raining → Wet) → (¬Raining → ¬Wet)


/- #4B [10 points]. 
-/

theorem contrapositive_valid : contrapositive :=
begin

/- #4C [5 points]. 

Give an English language proof of it.
-/


/- #5. Extra credit.

Complete the following formal proof of the 
proposition that if for any proposition P, 
P ∨ ¬P is true, then for any propositions, 
X and Y, if it's not the case that X or Y
is true then it is the case that ¬X and ¬Y 
is true. 
-/

theorem demorgan1 : 
  (∀ (P : Prop), P ∨ ¬ P) → 
    ∀ (X Y : Prop), 
      ¬(X ∨ Y) → (¬X ∧ ¬Y) :=
begin
assume em X Y nxory,
cases (em X) with x nx,
let foo := or.intro_left Y x,
_
end

/-
A comment on or.intro_left and or.intro_right.
In Lean each of these takes two arguments: a
proof of the disjunct -- the proposition on 
one side of the ∨ -- that is to be proven true, 
*and* it takes as an argument the proposition 
that is not being proven true. In applications 
of these rules the proposition argument (not 
being proven) comes first, while the proof 
argument comes second.

The reason is that Lean needs to know what 
overall proposition is being proved. From the
proof argument it can infer the proposition 
being proved, but it needs the other proposition
as well to know the full (X ∨ Y) disjunction to
be proved. 

Here's an example:
-/

example : 0 = 0 ∨ 0 = 1 :=
begin
apply or.intro_left (0 = 1) rfl
/-
The "rfl" serves as a proof of 0=0.
But in addition, as the first argument
to or.intro, we need to provide the
*proposition* that is not being proved.
Here's that's (0 = 1). In contexts
where Lean can infer both disuncts,
you can use the simpler or.inl or 
or.inr, each of which just takes one
argument: a proof of the left or of 
the right side, respectively.
-/
end

