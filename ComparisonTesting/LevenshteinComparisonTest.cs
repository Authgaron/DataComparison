using System;
using System.Data.SqlTypes;
using NUnit.Framework;


namespace ComparisonTesting
{
    [TestFixture]
    public class LevenshteinDistanceTest
    {
        [Test]
        public void EqualStringsHaveZeroDistance()
        {
            //G
            SqlString baseString = "test string";
            SqlString compareString = "test string";

            //W
            var result = UserDefinedFunctions.LevenshteinDistance(baseString, compareString, false);

            //T
            Assert.AreEqual((SqlInt32)0, result);
        }

        [Test]
        public void EmptyBaseStringsHaveCompareStringDistance()
        {
            //G
            SqlString baseString = "";
            SqlString compareString = "test compare string";

            //W
            var result = UserDefinedFunctions.LevenshteinDistance(baseString, compareString, false);

            //T
            Assert.AreEqual((SqlInt32)19, result);
        }

        [Test]
        public void EmptyCompareStringsHaveBaseStringDistance()
        {
            //G
            SqlString baseString = "test base string";
            SqlString compareString = "";

            //W
            var result = UserDefinedFunctions.LevenshteinDistance(baseString, compareString, false);

            //T
            Assert.AreEqual((SqlInt32)16, result);
        }

        [Test]
        public void DifferentLengthStringsGiveCorrectDistance()
        {
            //G
            SqlString baseString = "test base string";
            SqlString compareString = "test compare string";

            //W
            var result = UserDefinedFunctions.LevenshteinDistance(baseString, compareString, false);

            //T
            Assert.AreEqual((SqlInt32)5, result);
        }
    }
}
