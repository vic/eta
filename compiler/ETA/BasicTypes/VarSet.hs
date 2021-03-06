{-
(c) The University of Glasgow 2006
(c) The GRASP/AQUA Project, Glasgow University, 1992-1998
-}

module ETA.BasicTypes.VarSet (
        -- * Var, Id and TyVar set types
        VarSet, IdSet, TyVarSet, CoVarSet,

        -- ** Manipulating these sets
        emptyVarSet, unitVarSet, mkVarSet,
        extendVarSet, extendVarSetList, extendVarSet_C,
        elemVarSet, varSetElems, subVarSet,
        unionVarSet, unionVarSets, mapUnionVarSet,
        intersectVarSet, intersectsVarSet, disjointVarSet,
        isEmptyVarSet, delVarSet, delVarSetList, delVarSetByKey,
        minusVarSet, foldVarSet, filterVarSet, fixVarSet,
        lookupVarSet, mapVarSet, sizeVarSet, seqVarSet,
        elemVarSetByKey, partitionVarSet
    ) where

import ETA.BasicTypes.Var      ( Var, TyVar, CoVar, Id )
import ETA.BasicTypes.Unique
import ETA.Utils.UniqSet

{-
************************************************************************
*                                                                      *
\subsection{@VarSet@s}
*                                                                      *
************************************************************************
-}

type VarSet       = UniqSet Var
type IdSet        = UniqSet Id
type TyVarSet     = UniqSet TyVar
type CoVarSet     = UniqSet CoVar

emptyVarSet     :: VarSet
intersectVarSet :: VarSet -> VarSet -> VarSet
unionVarSet     :: VarSet -> VarSet -> VarSet
unionVarSets    :: [VarSet] -> VarSet

mapUnionVarSet  :: (a -> VarSet) -> [a] -> VarSet
-- ^ map the function oer the list, and union the results

varSetElems      :: VarSet  -> [Var]
unitVarSet       :: Var     -> VarSet
extendVarSet     :: VarSet  -> Var -> VarSet
extendVarSetList :: VarSet  -> [Var] -> VarSet
elemVarSet       :: Var     -> VarSet -> Bool
delVarSet        :: VarSet  -> Var -> VarSet
delVarSetList    :: VarSet  -> [Var] -> VarSet
minusVarSet      :: VarSet  -> VarSet -> VarSet
isEmptyVarSet    :: VarSet  -> Bool
mkVarSet         :: [Var]   -> VarSet
foldVarSet       :: (Var    -> a -> a) -> a -> VarSet -> a
lookupVarSet     :: VarSet  -> Var -> Maybe Var
                        -- Returns the set element, which may be
                        -- (==) to the argument, but not the same as
mapVarSet       :: (Var -> Var) -> VarSet -> VarSet
sizeVarSet      :: VarSet -> Int
filterVarSet    :: (Var -> Bool) -> VarSet -> VarSet
extendVarSet_C  :: (Var->Var->Var) -> VarSet -> Var -> VarSet

delVarSetByKey  :: VarSet -> Unique -> VarSet
elemVarSetByKey :: Unique -> VarSet -> Bool
fixVarSet       :: (VarSet -> VarSet) -> VarSet -> VarSet
partitionVarSet :: (Var -> Bool) -> VarSet -> (VarSet, VarSet)

emptyVarSet     = emptyUniqSet
unitVarSet      = unitUniqSet
extendVarSet    = addOneToUniqSet
extendVarSetList = addListToUniqSet
intersectVarSet = intersectUniqSets

intersectsVarSet :: VarSet -> VarSet -> Bool     -- True if non-empty intersection
disjointVarSet  :: VarSet -> VarSet -> Bool     -- True if empty intersection
subVarSet       :: VarSet -> VarSet -> Bool     -- True if first arg is subset of second
        -- (s1 `intersectsVarSet` s2) doesn't compute s2 if s1 is empty;
        -- ditto disjointVarSet, subVarSet

unionVarSet     = unionUniqSets
unionVarSets    = unionManyUniqSets
varSetElems     = uniqSetToList
elemVarSet      = elementOfUniqSet
minusVarSet     = minusUniqSet
delVarSet       = delOneFromUniqSet
delVarSetList   = delListFromUniqSet
isEmptyVarSet   = isEmptyUniqSet
mkVarSet        = mkUniqSet
foldVarSet      = foldUniqSet
lookupVarSet    = lookupUniqSet
mapVarSet       = mapUniqSet
sizeVarSet      = sizeUniqSet
filterVarSet    = filterUniqSet
extendVarSet_C = addOneToUniqSet_C
delVarSetByKey  = delOneFromUniqSet_Directly
elemVarSetByKey = elemUniqSet_Directly
partitionVarSet = partitionUniqSet

mapUnionVarSet get_set xs = foldr (unionVarSet . get_set) emptyVarSet xs

-- See comments with type signatures
intersectsVarSet s1 s2 = not (s1 `disjointVarSet` s2)
disjointVarSet   s1 s2 = isEmptyVarSet (s1 `intersectVarSet` s2)
subVarSet        s1 s2 = isEmptyVarSet (s1 `minusVarSet` s2)

-- Iterate f to a fixpoint
fixVarSet f s | new_s `subVarSet` s = s
              | otherwise           = fixVarSet f new_s
              where
                new_s = f s

seqVarSet :: VarSet -> ()
seqVarSet s = sizeVarSet s `seq` ()
