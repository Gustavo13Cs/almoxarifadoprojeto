using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using TDSAlmaxarifado.Models;

namespace TDSAlmaxarifadoTeste
{
    [TestClass]
    public class EstoqueTeste
    {
        [TestMethod]
        public void TemSaldoTrue()
        {
            bool esperado = true;
            bool resultado = true;
            PRODUTO produto = new PRODUTO();
            produto.PROID = 1;
            produto.PROESTOQUE = 10;

            ProdutoEstoque validarEStoque = new ProdutoEstoque();
            if (validarEStoque.verificarEstoque(produto,5)== true)
            {
                resultado = true;
            }
            else
            {
                resultado = false;
            }

            Assert.AreEqual(esperado, resultado);

        }
    }
}
