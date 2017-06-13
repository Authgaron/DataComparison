using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Collections.Generic;
using System.Collections;
using System.Linq;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlInt32 LevenshteinDistance(SqlString baseSqlString, SqlString compareSqlString, SqlBoolean caseSensitive)
    {
        string baseString = caseSensitive.Value ? baseSqlString.Value : baseSqlString.Value.ToLower();
        string compareString = caseSensitive.Value ? compareSqlString.Value : compareSqlString.Value.ToLower();

        if (baseString.Length == 0)
            return compareString.Length;
        if (compareString.Length == 0)
            return baseString.Length;

        List<int> previousRow = new List<int>();
        List<int> currentRow = Enumerable.Range(0,compareString.Length).ToList();
        
        for (int i = 1; i < baseString.Length; i++)
        {
            previousRow = currentRow;
            currentRow = new List<int> {i} ;

            var baseChar = baseString[i];

            for (int j = 1; j < compareString.Length ; j++)
            {
                var compareChar = compareString[j];
                var cost = baseChar == compareChar ? 0 : 1;
                currentRow.Add(
                    new [] {
                        previousRow[j] + 1,
                        currentRow[j-1] + 1,
                        previousRow[j-1] + cost
                    }.Min() 
                ); 
            }
        }

        return currentRow.Last();
    }
}
