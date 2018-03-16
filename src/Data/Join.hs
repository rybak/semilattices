module Data.Join where

import qualified Data.Semigroup as Semigroup
import qualified Data.Set as Set

-- | A join semilattice is an idempotent commutative semigroup.
class Join s where
  -- | The join operation.
  --
  --   Laws:
  --
  --   Idempotence:
  --
  --   > x \/ x = x
  --
  --   Associativity:
  --
  --   > a \/ (b \/ c) = (a \/ b) \/ c
  --
  --   Commutativity:
  --
  --   > a \/ b = b \/ a
  --
  --   Additionally, if @s@ has a 'LowerBound', the identity law must hold:
  --
  --   > bottom \/ a = a
  (\/) :: s -> s -> s

  infixr 6 \/


instance Join () where
  _ \/ _ = ()

instance Join Bool where
  (\/) = (||)

instance Ord a => Join (Semigroup.Max a) where
  (\/) = (Semigroup.<>)

instance Ord a => Join (Set.Set a) where
  (\/) = Set.union