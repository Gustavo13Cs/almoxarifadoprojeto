using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TDSAlmaxarifado.Models;

namespace TDSAlmaxarifado.Controllers
{
    public class ProdutoController : Controller
    {
        BDTDSAlmaxarifadoEntities bd = new BDTDSAlmaxarifadoEntities();

        // GET: Produto
        [HttpGet]
        public ActionResult Index()
        {
            //select * from produto
            return View(bd.PRODUTO.ToList());
        }  
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(string descricao,string minimo,string maximo,string estoque)
        {
            PRODUTO novoProduto = new PRODUTO();
            novoProduto.PRODESCRICAO = descricao;
            novoProduto.PROMINIMO = Convert.ToInt32(minimo);
            novoProduto.PROMAXIMO = Convert.ToInt32(maximo);
            novoProduto.PROESTOQUE = Convert.ToInt32(estoque);

            bd.PRODUTO.Add(novoProduto);
            bd.SaveChanges();

            return RedirectToAction("index");
        }
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            PRODUTO produtoLocalizar = bd.PRODUTO.ToList().Where(x => x.PROID == id).First();
            return View(produtoLocalizar);
        }

        [HttpPost]
        public ActionResult Edit (int? id,string descricao, string minimo, string maximo, string estoque)
        {
            PRODUTO atualizarProduto = bd.PRODUTO.ToList().Where(x => x.PROID == id).First();
            atualizarProduto.PRODESCRICAO = descricao;
            atualizarProduto.PROMINIMO = Convert.ToInt32(minimo);
            atualizarProduto.PROMAXIMO = Convert.ToInt32(maximo);
            atualizarProduto.PROESTOQUE = Convert.ToInt32(estoque);

            bd.Entry(atualizarProduto).State = EntityState.Modified;
            bd.SaveChanges();
            return RedirectToAction("index");
        }

        public ActionResult Delete(int? id)
        {
            PRODUTO excluirProduto = bd.PRODUTO.ToList().Where(x => x.PROID == id).First();
            return View(excluirProduto);
        }


        [HttpPost]
        public ActionResult DeleteConfirma(int? id)
        {
            PRODUTO excluirProduto = bd.PRODUTO.ToList().Where(x => x.PROID == id).First();
            bd.PRODUTO.Remove(excluirProduto);
            try
            {
               bd.SaveChanges();
            }
            catch (Exception)
            {
                return RedirectToAction("index");
            }

            return RedirectToAction("index");
        }
        public ActionResult Details(int? id)
        {
            return View();
        }





    }
}